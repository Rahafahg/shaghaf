part of 'profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

final class EditUserProfileEvent extends UserProfileEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  EditUserProfileEvent(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber});
}

final class SubmitUserProfileEvent extends UserProfileEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  SubmitUserProfileEvent(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber});
}

final class ViewUserProfileEvent extends UserProfileEvent {}