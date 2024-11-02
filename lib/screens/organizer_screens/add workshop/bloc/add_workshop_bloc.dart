import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
part 'add_workshop_event.dart';
part 'add_workshop_state.dart';

class AddWorkshopBloc extends Bloc<AddWorkshopEvent, AddWorkshopState> {
  int currentStep = 0;
  late String type = workshop?.isOnline == true ? "Online".tr() : "InSite".tr();
  late bool isOnline = workshop?.isOnline ?? false;
  double? latitude;
  double? longitude;
  Workshop? workshop;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController audienceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late TextEditingController timeFromController =
      TextEditingController(text: workshop?.fromTime);
  late TextEditingController timeToController =
      TextEditingController(text: workshop?.toTime);
  File? instructorimage;
  late TextEditingController instructorNameController =
      TextEditingController(text: workshop?.instructorName);
  late TextEditingController instructorDescController =
      TextEditingController(text: workshop?.instructorDescription);
  late TextEditingController priceController =
      TextEditingController(text: workshop?.price.toString());
  late TextEditingController seatsController =
      TextEditingController(text: workshop?.numberOfSeats.toString());
  late TextEditingController venueNameController =
      TextEditingController(text: workshop?.venueName);
  late TextEditingController venueTypeController =
      TextEditingController(text: workshop?.venueType);
  late TextEditingController LinlUrlController =
      TextEditingController(text: workshop?.meetingUrl);
  AddWorkshopBloc() : super(AddWorkshopInitial()) {
    on<StepContinueEvent>(stepContinue);
    on<StepCancelEvent>(stepCancel);
    on<ChangeImageEvent>(changeImage);
    on<ChangeTypeEvent>(changeType);
    on<SubmitWorkshopEvent>(submitWorkshopMethod);
    on<GetOrgWorkshopsEvent>((event, emit) {
      getOrgWorkshops();
      GetIt.I.get<SupabaseLayer>().getAllReviews();
      emit(ShowWorkshopsState());
    });
    on<SpecifyLocationEvent>(specifyLocation);
  }

  FutureOr<void> submitWorkshopMethod(
      SubmitWorkshopEvent event, Emitter<AddWorkshopState> emit) async {
    emit(LoadingState());
    if (event.isSingleWorkShope == false) {
      await GetIt.I.get<SupabaseLayer>().addWorkshop(
          title: titleController.text,
          workshopImage: event.image,
          description: descController.text,
          categoryId: GetIt.I
              .get<DataLayer>()
              .categories
              .firstWhere((category) =>
                  category.categoryName == categoryController.text)
              .categoryId,
          targetedAudience: audienceController.text,
          date: dateController.text,
          availableSeats: int.parse(seatsController.text),
          from: timeFromController.text,
          to: timeToController.text,
          instructorDesc: instructorDescController.text,
          instructorName: instructorNameController.text,
          instructorImage: instructorimage,
          price: double.parse(priceController.text),
          seats: int.parse(seatsController.text),
          venueName: venueNameController.text,
          venueType: venueTypeController.text,
          meetingUrl: LinlUrlController.text,
          isOnline: isOnline,
          longitude: longitude.toString(),
          latitude: latitude.toString());
    } else {
      await GetIt.I.get<SupabaseLayer>().addSingleWorkshop(
          isEdit: event.isEdit,
          workshopId: event.workshopId,
          workshopGroupId: workshop!.workshopGroupId,
          date: dateController.text,
          from: timeFromController.text,
          to: timeToController.text,
          instructorImage: instructorimage,
          price: double.parse(priceController.text),
          seats: int.parse(seatsController.text),
          availableSeats: int.parse(seatsController.text),
          instructorName: instructorNameController.text,
          instructorDesc: instructorDescController.text,
          venueName: venueNameController.text,
          venueType: venueTypeController.text,
          meetingUrl: LinlUrlController.text,
          longitude: longitude.toString(),
          latitude: latitude.toString(),
          isOnline: isOnline);
    }
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
    log("-----------------aaaaaaaaaaaaaaa1");
    emit(ChangeImageState(image: event.image));
  }

  FutureOr<void> changeType(
      ChangeTypeEvent event, Emitter<AddWorkshopState> emit) {
    type = event.type;
    isOnline = !isOnline;
    emit(ChangeDateState());
  }

  FutureOr<void> specifyLocation(
      SpecifyLocationEvent event, Emitter<AddWorkshopState> emit) {
    latitude = event.point.latitude;
    longitude = event.point.longitude;
    emit(SpecifyLocationState(point: event.point));
  }
}
