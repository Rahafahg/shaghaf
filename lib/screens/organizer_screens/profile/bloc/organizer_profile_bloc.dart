import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
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
  File? tempImageFile; // Temporary image to hold new selected image

  OrganizerProfileBloc() : super(OrganizerProfileInitial()) {
    on<ViewOrgProfileEvent>(onViewOrgProfile);
    on<EditOrqProfileEvent>(onEditOrgProfile);
    on<SubmitOrgProfileEvent>(onSubmitOrgProfile);
    on<UpdateProfileImageEvent>(onUpdateProfileImage);
  }

  FutureOr<void> onViewOrgProfile(
      ViewOrgProfileEvent event, Emitter<OrganizerProfileState> emit) {
    final organizer = GetIt.I.get<AuthLayer>().organizer;
    if (organizer != null) {
      nameController.text = organizer.name;
      phoneNumberController.text = organizer.contactNumber;
      descriptionController.text = organizer.description;
      emit(SuccessOrgProfileState(imageFile: selectedImageFile));
    } else {
      print("-----there is somthing 1----");
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
      
      // Update selected image with tempImageFile upon submission
      selectedImageFile = tempImageFile;
      authLayer.organizer!.image = selectedImageFile?.path ?? authLayer.organizer!.image;
      
      authLayer.box.write('organizer', authLayer.organizer!.toJson());
      emit(SuccessOrgProfileState(imageFile: selectedImageFile));
    } catch (e) {
      print("----there is something here 2---");
    }
  }

  FutureOr<void> onUpdateProfileImage(
      UpdateProfileImageEvent event, Emitter<OrganizerProfileState> emit) {
    selectedImageFile = event.imageFile;
    emit(SuccessOrgProfileState(imageFile: selectedImageFile));
  }
}


// import 'dart:async';
// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shaghaf/data_layer/auth_layer.dart';
// import 'package:shaghaf/data_layer/supabase_layer.dart';

// part 'organizer_profile_event.dart';
// part 'organizer_profile_state.dart';

// class OrganizerProfileBloc extends Bloc<OrganizerProfileEvent, OrganizerProfileState> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   File? selectedImageFile;

//   OrganizerProfileBloc() : super(OrganizerProfileInitial()) {
//     on<ViewOrgProfileEvent>(_onViewOrgProfile);
//     on<EditOrqProfileEvent>(_onEditOrgProfile);
//     on<SubmitOrgProfileEvent>(_onSubmitOrgProfile);
//     on<UpdateProfileImageEvent>(_onUpdateProfileImage);
//   }

//   Future<void> _onViewOrgProfile(
//       ViewOrgProfileEvent event, Emitter<OrganizerProfileState> emit) async {
//     final organizer = GetIt.I.get<AuthLayer>().organizer;
//     if (organizer != null) {
//       nameController.text = organizer.name;
//       phoneNumberController.text = organizer.contactNumber;
//       descriptionController.text = organizer.description;
//       emit(SuccessOrgProfileState(imageFile: selectedImageFile));
//     } else {
//  //     emit(ErrorOrgProfileState(message: "Organizer data not found."));
//     }
//   }

//   Future<void> _onEditOrgProfile(
//       EditOrqProfileEvent event, Emitter<OrganizerProfileState> emit) async {
//     nameController.text = event.name;
//     phoneNumberController.text = event.contactNumber;
//     descriptionController.text = event.description;
//     emit(EditingOrgProfileState());
//   }

//   Future<void> _onSubmitOrgProfile(
//       SubmitOrgProfileEvent event, Emitter<OrganizerProfileState> emit) async {
//     emit(LoadingOrgProfileState());
//     try {
//       final authLayer = GetIt.I.get<AuthLayer>();

//       await GetIt.I.get<SupabaseLayer>().supabase.from('organizer').update({
//         'name': event.name,
//         'description': event.description,
//         'contact_number': event.contactNumber,
//       }).eq('organizer_id', authLayer.organizer!.organizerId);

//       authLayer.organizer!
//         ..name = event.name
//         ..description = event.description
//         ..contactNumber = event.contactNumber
//         ..image = selectedImageFile?.path ?? authLayer.organizer!.image;

//       await authLayer.box.write('organizer', authLayer.organizer!.toJson());
//       emit(SuccessOrgProfileState(imageFile: selectedImageFile));
//     } catch (e) {
//      // emit(ErrorOrgProfileState(message: "Failed to submit profile data."));
//     }
//   }

//   Future<void> _onUpdateProfileImage(
//       UpdateProfileImageEvent event, Emitter<OrganizerProfileState> emit) async {
//     selectedImageFile = event.imageFile;
//     emit(SuccessOrgProfileState(imageFile: selectedImageFile));
//   }

//   @override
//   Future<void> close() {
//     nameController.dispose();
//     phoneNumberController.dispose();
//     descriptionController.dispose();
//     return super.close();
//   }
// }
