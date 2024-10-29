part of 'add_workshop_bloc.dart';

@immutable
sealed class AddWorkshopEvent {}

final class StepContinueEvent extends AddWorkshopEvent {}

final class StepCancelEvent extends AddWorkshopEvent {}

final class ChangeImageEvent extends AddWorkshopEvent {
  final File? image;

  ChangeImageEvent({required this.image});
}

final class ChangeTypeEvent extends AddWorkshopEvent {
  final String type;
  ChangeTypeEvent({required this.type});
}

final class AddDateEvent extends AddWorkshopEvent {
  final String date;
  AddDateEvent({required this.date});
}

final class SubmitWorkshopEvent extends AddWorkshopEvent {
  final File? image;
  final bool isSingleWorkShope;
  SubmitWorkshopEvent({required this.isSingleWorkShope,  this.image});
}

final class GetOrgWorkshopsEvent extends AddWorkshopEvent {}
