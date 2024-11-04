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

final class ChooseCategoryEvent extends AddWorkshopEvent {
  final String category;
  ChooseCategoryEvent({required this.category});
}


final class AddDateEvent extends AddWorkshopEvent {
  final String date;
  AddDateEvent({required this.date});
}

final class SubmitWorkshopEvent extends AddWorkshopEvent {
  final File? image;
  final bool isSingleWorkShope;
  final bool? isEdit;
  final String? workshopId;
  SubmitWorkshopEvent({required this.isSingleWorkShope, this.image, this.isEdit=false, this.workshopId});
}

final class GetOrgWorkshopsEvent extends AddWorkshopEvent {}

final class SpecifyLocationEvent extends AddWorkshopEvent {
  final LatLng point;
  SpecifyLocationEvent({required this.point});
}