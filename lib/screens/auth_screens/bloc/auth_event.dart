part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  VerifyOtpEvent({required this.email, required this.firstName, required this.lastName, required this.otp, required this.phoneNumber});
}

final class CreateAccountEvent extends AuthEvent {
  final String email;
  final String password;
  CreateAccountEvent({required this.email, required this.password});
}

// final class CreateOrganizerAccountEvent extends AuthEvent {}

final class LoginEvent extends AuthEvent {}