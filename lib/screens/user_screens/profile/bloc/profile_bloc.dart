import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  UserProfileBloc() : super(ProfileInitial()) {
    on<EditUserProfileEvent>(editUserProfile);
    on<SubmitUserProfileEvent>(submitUserProfile);
    on<ViewUserProfileEvent>((event, emit) {
      if(GetIt.I.get<AuthLayer>().user != null) {
        FocusManager.instance.primaryFocus?.unfocus();
        emit(SuccessProfileState());
      }
    });
  }

  FutureOr<void> editUserProfile(
      EditUserProfileEvent event, Emitter<UserProfileState> emit) {
    firstNameController.text = event.firstName;
    lastNameController.text = event.lastName;
    phoneNumberController.text = event.phoneNumber;
    emit(EditingProfileState());
  }


  Future<void> submitUserProfile(
    SubmitUserProfileEvent event, Emitter<UserProfileState> emit) async {
  log("submit");

  try {
    // Supabase update operation
    emit(LoadingProfileState());
    await GetIt.I.get<SupabaseLayer>().supabase.from('users').update({
      'first_name': event.firstName,
      'last_name': event.lastName,
      'phone_number': event.phoneNumber
    }).eq('user_id', GetIt.I.get<AuthLayer>().user!.userId);

    log("submit2");

    // Check for null AuthLayer or user
    var authLayer = GetIt.I.get<AuthLayer>();
    if (authLayer.user == null) {
      log("AuthLayer or user is null!");
      return;
    }

    // Update local user info
    log("Updating user info");
    authLayer.user!.firstName = event.firstName;
    authLayer.user!.lastName = event.lastName;
    authLayer.user!.phoneNumber = event.phoneNumber;
    log("submit3");

    // Write user data to storage
    try {
      log("Writing user to storage");
      authLayer.box.write('user', authLayer.user!.toJson());
      log("submit4");
    } catch (e) {
      log("Error writing to storage: $e");
      return;
    }

    // Emit success state
    emit(SuccessProfileState());
    log("submit5");

  } catch (e) {
    log("Exception occurred: $e");
    // emit(ErrorProfileState(e.toString()));
  }
}

}
