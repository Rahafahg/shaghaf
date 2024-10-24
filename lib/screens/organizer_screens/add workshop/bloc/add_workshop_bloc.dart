import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_workshop_event.dart';
part 'add_workshop_state.dart';

class AddWorkshopBloc extends Bloc<AddWorkshopEvent, AddWorkshopState> {
  int currentStep = 0;

  AddWorkshopBloc() : super(AddWorkshopInitial()) {
    on<StepContinueEvent>(stepContinue);
    on<StepCancelEvent>(stepCancel);
    on<ChangeImageEvent>(changeImage);
  }

  FutureOr<void> stepContinue(
      StepContinueEvent event, Emitter<AddWorkshopState> emit) {
    if (currentStep < 2) {
      currentStep += 1;
      emit(ChangeStepState());
    }
  }

  FutureOr<void> stepCancel(
      StepCancelEvent event, Emitter<AddWorkshopState> emit) {
    if (currentStep > 0) {
      currentStep -= 1;
      emit(ChangeStepState());
    }
  }

  FutureOr<void> changeImage(
      ChangeImageEvent event, Emitter<AddWorkshopState> emit) {
    print("-----------------aaaaaaaaaaaaaaa1");
    emit(ChangeImageState(image: event.image));
  }
}
