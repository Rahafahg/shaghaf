part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  VerifyOtpEvent({required this.email,required this.firstName,required this.lastName,required this.otp,required this.phoneNumber});
}

final class VerifyOrganizerOtpEvent extends AuthEvent {
  final String email;
  final String otp;
  final String name;
  final File? image;
  final String contactNumber;
  final String licenseNumber;
  final String description;
  VerifyOrganizerOtpEvent({required this.email,required this.otp,required this.contactNumber,required this.description,required this.image,required this.licenseNumber,required this.name});
}

final class CreateAccountEvent extends AuthEvent {
  final String email;
  final String password;
  CreateAccountEvent({required this.email, required this.password});
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

final class LoginWithEmailEvent extends AuthEvent {}

final class AddingImageEvent extends AuthEvent {
  final File? image;
  AddingImageEvent({required this.image});
}
