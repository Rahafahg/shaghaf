import 'dart:async';
import 'dart:developer';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final supabaseLayer = GetIt.I.get<SupabaseLayer>();
  TextEditingController otpController = TextEditingController();
  // final String externalId = Random().nextInt(999999999).toString();
  final String externalId = '1234567890';

  AuthBloc() : super(AuthInitial()) {
    on<CreateAccountEvent>(createUserAccountMethod);
    on<VerifyOtpEvent>(verifyOtpMethod);
    on<VerifyOrganizerOtpEvent>(verifyOrganizerOtpMethod);
    on<LoginEvent>(loginMethod);
    on<LoginWithEmailEvent>(loginWithEmailMethod);
  }

  FutureOr<void> createUserAccountMethod(
      CreateAccountEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final AuthResponse response = await supabaseLayer.createAccount(
          email: event.email, password: event.password);

      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(msg: 'User already exists or something went wrong :('));
    }
  }

  FutureOr<void> verifyOtpMethod(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await supabaseLayer.verifyOtp(
          email: event.email,
          otp: event.otp,
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
          externalId: externalId);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> loginMethod(LoginEvent event, Emitter<AuthState> emit) async {
    String role = "";
    try {
      emit(LoadingState());
      final users = <Future>[];
      users.add(supabaseLayer.supabase.from('organizer').select('email'));
      users.add(supabaseLayer.supabase.from('users').select('email'));
      final results = await Future.wait(users);
      log(results[1][0].toString());
      for (var user in results[1]) {
        log(user['email'].toString());
        if (event.email == user['email'].toString()) {
          role = 'user';
          log(role);
          break;
        }
        log('no');
      }
      log(results[0][0].toString());
      for (var organizer in results[0]) {
        log(organizer['email'].toString());
        if (event.email == organizer['email'].toString()) {
          role = 'organizer';
          log(role);
          break;
        }
        log('no');
      }
      if (role == 'user' || role == 'organizer') {
        await supabaseLayer.supabase.auth
            .signInWithPassword(email: event.email, password: event.password);
        // log(login.toString());
        emit(SuccessState(role: role));
      }
    } catch (e) {
      emit(ErrorState(msg: 'User not found'));
    }
  }

  Future<void> verifyOrganizerOtpMethod(
      VerifyOrganizerOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await supabaseLayer.verifyOrganizerOtp(
          email: event.email,
          otp: event.otp,
          name: event.name,
          contactNumber: event.contactNumber,
          description: event.description,
          image: event.image);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> loginWithEmailMethod(
      LoginWithEmailEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
   final AuthResponse response =  await supabaseLayer.nativeGoogleSignIn();
    String role = "";
   final users = <Future>[];
      users.add(supabaseLayer.supabase.from('organizer').select('email'));
      users.add(supabaseLayer.supabase.from('users').select('email'));
      final results = await Future.wait(users);
      log(results[1][0].toString());
      for (var user in results[1]) {
        log(user['email'].toString());
        if (response.user?.email == user['email'].toString()) {
          role = 'user';
          log(role);
          break;
        }
        log('no');
      }
      log(results[0][0].toString());
      for (var organizer in results[0]) {
        log(organizer['email'].toString());
        if (response.user?.email == organizer['email'].toString()) {
          role = 'organizer';
          log(role);
          break;
        }
        log('no');
      }
      emit(SuccessState(role: role));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }
}
