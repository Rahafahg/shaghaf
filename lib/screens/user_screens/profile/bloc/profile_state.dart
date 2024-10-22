part of 'profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class ProfileInitial extends UserProfileState {}

final class LoadingProfileState extends UserProfileState {}

final class ErrorProfileState extends UserProfileState {
  final String msg;
  ErrorProfileState({required this.msg});
}

final class SuccessProfileState extends UserProfileState {}

final class EditingProfileState extends UserProfileState {}
