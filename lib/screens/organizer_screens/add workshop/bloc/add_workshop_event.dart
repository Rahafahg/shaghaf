part of 'add_workshop_bloc.dart';

@immutable
sealed class AddWorkshopEvent {}

final class StepContinueEvent extends AddWorkshopEvent {}

final class StepCancelEvent extends AddWorkshopEvent {}

final class ChangeImageEvent extends AddWorkshopEvent {
  final File? image;

  ChangeImageEvent({required this.image});
}

final class ChangeDateEvent extends AddWorkshopEvent {
  final int index;
  ChangeDateEvent({required this.index});
}

final class AddDateEvent extends AddWorkshopEvent {
  final String date;
  AddDateEvent({required this.date});
}

final class SubmitWorkshopEvent extends AddWorkshopEvent {
  final File image;
  SubmitWorkshopEvent({required this.image});
}