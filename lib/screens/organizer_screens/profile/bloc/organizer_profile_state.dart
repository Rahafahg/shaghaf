part of 'organizer_profile_bloc.dart';

@immutable
sealed class OrganizerProfileState {}

final class OrganizerProfileInitial extends OrganizerProfileState {}

final class LoadingOrgProfileState extends OrganizerProfileState {}

final class ErrorProfileState extends OrganizerProfileState {
  final String msg;
  ErrorProfileState({required this.msg});
}

final class SuccessOrgProfileState extends OrganizerProfileState {
  final File? imageFile;

  SuccessOrgProfileState({this.imageFile});

  get organizerContact => null;
}

final class EditingOrgProfileState extends OrganizerProfileState {}
