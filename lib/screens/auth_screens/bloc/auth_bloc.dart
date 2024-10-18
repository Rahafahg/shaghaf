import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final supabaseLayer = GetIt.I.get<SupabaseLayer>();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final String externalId = Random().nextInt(999999999).toString();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<CreateAccountEvent>(createUserAccountMethod);
    on<VerifyOtpEvent>(verifyOtpMethod);
  }

  FutureOr<void> verifyOtpMethod(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await supabaseLayer.verifyOtp(
        email: event.email,
        otp: event.otp,
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
        externalId: externalId
      );
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  FutureOr<void> createUserAccountMethod(CreateAccountEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      await supabaseLayer.createAccount(email: emailController.text, password: passwordController.text);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}