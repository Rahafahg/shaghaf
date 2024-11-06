import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';

part 'organizer_profile_event.dart';
part 'organizer_profile_state.dart';

class OrganizerProfileBloc
    extends Bloc<OrganizerProfileEvent, OrganizerProfileState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? selectedImageFile;
  File? tempImageFile;
  String? imageUrl;

  OrganizerProfileBloc() : super(OrganizerProfileInitial()) {
    on<ViewOrgProfileEvent>(onViewOrgProfile);
    on<EditOrqProfileEvent>(onEditOrgProfile);
    on<SubmitOrgProfileEvent>(onSubmitOrgProfile);
    on<UpdateProfileImageEvent>(onUpdateProfileImage);
    on<CloseEditOrgProfileEvent>((event, emit) {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(SuccessOrgProfileState());
    });
  }

  FutureOr<void> onViewOrgProfile(
      ViewOrgProfileEvent event, Emitter<OrganizerProfileState> emit) {
    final organizer = GetIt.I.get<AuthLayer>().organizer;
    if (organizer != null) {
      nameController.text = organizer.name;
      phoneNumberController.text = organizer.contactNumber;
      descriptionController.text = organizer.description;
      emit(SuccessOrgProfileState(imageFile: selectedImageFile));
    }
  }

  FutureOr<void> onEditOrgProfile(
      EditOrqProfileEvent event, Emitter<OrganizerProfileState> emit) {
    nameController.text = event.name;
    phoneNumberController.text = event.contactNumber;
    descriptionController.text = event.description;
    emit(EditingOrgProfileState());
  }

  FutureOr<void> onSubmitOrgProfile(
      SubmitOrgProfileEvent event, Emitter<OrganizerProfileState> emit) async {
    try {
      emit(LoadingOrgProfileState());

      await GetIt.I.get<SupabaseLayer>().supabase.from('organizer').update({
        'name': event.name,
        'description': event.description,
        'contact_number': event.contactNumber,
      }).eq('organizer_id', GetIt.I.get<AuthLayer>().organizer!.organizerId);

      var authLayer = GetIt.I.get<AuthLayer>();
      authLayer.organizer!.name = event.name;
      authLayer.organizer!.description = event.description;
      authLayer.organizer!.contactNumber = event.contactNumber;

      authLayer.box.write('organizer', authLayer.organizer!.toJson());
      emit(SuccessOrgProfileState(imageFile: selectedImageFile));
    } catch (_) {}
  }

  Future<void> onUpdateProfileImage(UpdateProfileImageEvent event,
      Emitter<OrganizerProfileState> emit) async {
    selectedImageFile = event.imageFile;
    String format = selectedImageFile!.path.split('.').last.toLowerCase();
    if (format == 'jpeg' || format == 'jpg' || format == 'png') {
      GetIt.I.get<AuthLayer>().organizer!.image =
          selectedImageFile?.path ?? GetIt.I.get<AuthLayer>().organizer!.image;
      try {
        await GetIt.I
            .get<SupabaseLayer>()
            .supabase
            .storage
            .from('organizer_images')
            .upload('public/${selectedImageFile!.path.split('/').last}',
                selectedImageFile!);
      } catch (e) {
        log("error aploading: $e");
      }
      try {
        imageUrl = GetIt.I
            .get<SupabaseLayer>()
            .supabase
            .storage
            .from('organizer_images')
            .getPublicUrl('public/${selectedImageFile!.path.split('/').last}');
      } catch (e) {
        log('error url: $e');
      }
      try {
        await GetIt.I
            .get<SupabaseLayer>()
            .supabase
            .from('organizer')
            .update({'image': imageUrl}).eq('organizer_id',
                GetIt.I.get<AuthLayer>().organizer!.organizerId);
      } catch (e) {
        log("error updating: $e");
      }
      emit(SuccessOrgProfileState(imageFile: selectedImageFile));
    } else {
      emit(ErrorImageProfileState(msg: 'Your image format is not supported, try using jpeg, jpg or png'));
    }
  }
}