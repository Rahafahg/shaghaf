import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';

part 'add_workshop_event.dart';
part 'add_workshop_state.dart';

class AddWorkshopBloc extends Bloc<AddWorkshopEvent, AddWorkshopState> {
  // List<String> dates = [DateTime.now().toString()];
  // List<Widget> workShopForms = [];
  // List <String>controllers = [];
  // Map<String, List<String>> controllers = {};
  // void addItem({required String key, required String item}) {

  //   if (controllers.containsKey(key)) {

  //     controllers[key]!.add(item);
  //   } else {

  //     controllers[key] = [item];
  //   }
  // }

  int currentStep = 0;
  int index = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController audienceController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  // TextEditingController titleController = TextEditingController();
  AddWorkshopBloc() : super(AddWorkshopInitial()) {
    on<StepContinueEvent>(stepContinue);
    on<StepCancelEvent>(stepCancel);
    on<ChangeImageEvent>(changeImage);
    on<ChangeDateEvent>(changeDate);
    on<SubmitWorkshopEvent>((event, emit) async {
      await GetIt.I.get<SupabaseLayer>().addWorkshop(
        title: titleController.text,
        workshopImage: event.image,
        description: descController.text,
        categoryId: GetIt.I.get<DataLayer>().categories.firstWhere((category)=>category.categoryName==categoryController.text).categoryId,
        targetedAudience: audienceController.text
      );
    });
    // on<AddDateEvent>(addDate);
  }

  FutureOr<void> stepContinue(StepContinueEvent event, Emitter<AddWorkshopState> emit) {
    if (currentStep < 1) {
      currentStep += 1;
      emit(ChangeStepState());
    }
  }

  FutureOr<void> stepCancel(StepCancelEvent event, Emitter<AddWorkshopState> emit) {
    if (currentStep > 0) {
      currentStep -= 1;
      emit(ChangeStepState());
    }
  }

  FutureOr<void> changeImage(ChangeImageEvent event, Emitter<AddWorkshopState> emit) {
    print("-----------------aaaaaaaaaaaaaaa1");
    emit(ChangeImageState(image: event.image));
  }

  FutureOr<void> changeDate(ChangeDateEvent event, Emitter<AddWorkshopState> emit) {
    index = event.index;
    emit(ChangeDateState());
  }
}