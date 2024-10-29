import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';

part 'add_workshop_event.dart';
part 'add_workshop_state.dart';

class AddWorkshopBloc extends Bloc<AddWorkshopEvent, AddWorkshopState> {
  int currentStep = 0;
  String type = "InSite";
  bool isOnline = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController audienceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  File? instructorimage; // handle me later
  TextEditingController instructorNameController = TextEditingController();
  TextEditingController instructorDescController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController venueNameController = TextEditingController();
  TextEditingController venueTypeController = TextEditingController();
  TextEditingController LinlUrlController = TextEditingController();
  AddWorkshopBloc() : super(AddWorkshopInitial()) {
    on<StepContinueEvent>(stepContinue);
    on<StepCancelEvent>(stepCancel);
    on<ChangeImageEvent>(changeImage);
    on<ChangeTypeEvent>(changeType);
    on<SubmitWorkshopEvent>(submitWorkshopMethod);
    on<GetOrgWorkshopsEvent>((event, emit) {
      getOrgWorkshops();
      emit(ShowWorkshopsState());
    });
  }

  FutureOr<void> submitWorkshopMethod(
      SubmitWorkshopEvent event, Emitter<AddWorkshopState> emit) async {
    await GetIt.I.get<SupabaseLayer>().addWorkshop(
        title: titleController.text,
        workshopImage: event.image,
        description: descController.text,
        categoryId: GetIt.I
            .get<DataLayer>()
            .categories
            .firstWhere(
                (category) => category.categoryName == categoryController.text)
            .categoryId,
        targetedAudience: audienceController.text,
        date: dateController.text,
        availableSeats: int.parse(seatsController.text),
        from: timeFromController.text,
        to: timeToController.text,
        instructorDesc: instructorDescController.text,
        instructorName: instructorNameController.text,
        price: double.parse(priceController.text),
        seats: int.parse(seatsController.text),
        venueName: venueNameController.text,
        venueType: venueTypeController.text,
        meetingUrl: LinlUrlController.text,
        isOnline: isOnline);
    await GetIt.I.get<SupabaseLayer>().getAllWorkshops();
    await getOrgWorkshops();
    log(GetIt.I.get<DataLayer>().orgWorkshops.length.toString());
    emit(AddSuccessState());
  }

  FutureOr<void> stepContinue(
      StepContinueEvent event, Emitter<AddWorkshopState> emit) {
    if (currentStep < 1) {
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

  FutureOr<void> changeType(
      ChangeTypeEvent event, Emitter<AddWorkshopState> emit) {
    type = event.type;
    isOnline = !isOnline;
    emit(ChangeDateState());
  }
}
