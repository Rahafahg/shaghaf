part of 'add_workshop_bloc.dart';

@immutable
sealed class AddWorkshopState {}

final class AddWorkshopInitial extends AddWorkshopState {}

final class ChangeStepState extends AddWorkshopState {}

final class ChangeImageState extends AddWorkshopState {
   final File? image;

  ChangeImageState({required this.image});
}
