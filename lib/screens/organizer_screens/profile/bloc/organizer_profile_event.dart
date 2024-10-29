part of 'organizer_profile_bloc.dart';

@immutable
sealed class OrganizerProfileEvent {}


final class EditOrqProfileEvent extends OrganizerProfileEvent {
  final String name;
  final String contactNumber;
  final String description; 
  EditOrqProfileEvent(
      {required this.name,
required this.description,
      required this.contactNumber});
}

final class SubmitOrgProfileEvent extends OrganizerProfileEvent {
  final String name;
  final String description; 
  final String contactNumber;
  SubmitOrgProfileEvent(
      {required this.name,
required this.description,
      required this.contactNumber});
}

final class ViewOrgProfileEvent extends OrganizerProfileEvent {}

class UpdateProfileImageEvent extends OrganizerProfileEvent {
  final File imageFile;

  UpdateProfileImageEvent(this.imageFile);
}

final class CloseEditOrgProfileEvent extends OrganizerProfileEvent {}