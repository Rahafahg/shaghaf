part of 'add_workshop_bloc.dart';

@immutable
sealed class AddWorkshopEvent {}

final class StepContinueEvent extends AddWorkshopEvent {}

final class StepCancelEvent extends AddWorkshopEvent {}

final class ChangeImageEvent extends AddWorkshopEvent {
  final File? image;

  ChangeImageEvent({required this.image});
}
