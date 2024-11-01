import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as mm;
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
  final String externalId = mm.Random().nextInt(999999999).toString();
  // final String externalId = '1234567890';
  File? selectedImage;

  AuthBloc() : super(AuthInitial()) {
    on<CreateAccountEvent>(createUserAccountMethod);
    on<VerifyOtpEvent>(verifyOtpMethod);
    on<VerifyOrganizerOtpEvent>(verifyOrganizerOtpMethod);
    on<LoginEvent>(loginMethod);
    on<RequestResetPasswordEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await supabaseLayer.supabase.auth.resetPasswordForEmail(event.email);
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: 'Something went wrong :('));
      }
    });
    on<UpdatePasswordEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await supabaseLayer.supabase.auth.updateUser(UserAttributes(email: event.email, password: event.newPassword));
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: 'Something went wrong :('));
      }
    });
    on<LoginWithEmailEvent>(loginWithEmailMethod);
    on<AddingImageEvent>(AddingImageMethod);
  }

  FutureOr<void> createUserAccountMethod(
      CreateAccountEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await supabaseLayer.createAccount(email: event.email, password: event.password);
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
      emit(ErrorState(msg: "Incorrect OTP"));
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
        await supabaseLayer.login(
            email: event.email,
            password: event.password,
            externalId: externalId,
            role: role);
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
      emit(ErrorState(msg: "Incorrect OTP"));
    }
  }

  FutureOr<void> loginWithEmailMethod(
      LoginWithEmailEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
//  final h = await supabaseLayer.supabase.auth.signInWithOAuth(
//   OAuthProvider.google,
//   redirectTo: 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
//   authScreenLaunchMode:
//       kDebugMode ? LaunchMode.platformDefault : LaunchMode.externalApplication, // Launch the auth screen in a new webview on mobile.
// );
// log(h.toString());
      final AuthResponse response = await supabaseLayer.nativeGoogleSignIn();
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
      emit(SuccessState(role: 'user'));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  FutureOr<void> AddingImageMethod(
      AddingImageEvent event, Emitter<AuthState> emit) {
    print("---------------image added----------");
    selectedImage = event.image;
    emit(AddingImageState(image: event.image));
  }
}
