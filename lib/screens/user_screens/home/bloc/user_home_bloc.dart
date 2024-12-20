import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final supabaseLayer = GetIt.I.get<SupabaseLayer>();
  final dataLayer = GetIt.I.get<DataLayer>();
  bool changedCategory = false;
  UserHomeBloc() : super(UserHomeInitial()) {
    on<GetWorkshopsEvent>(getWorkshopsMethod);
    on<HomeSearchEvent>(searchMethod);
    on<ChangeCategoryEvent>(changeCategory);
  }

  FutureOr<void> searchMethod(
      HomeSearchEvent event, Emitter<UserHomeState> emit) {
    if (event.search.isEmpty) {
      emit(
          SuccessWorkshopsState(search: false, workshops: dataLayer.workshops));
    } else {
      emit(SuccessWorkshopsState(
          search: true,
          searchTerm: event.search,
          workshops: dataLayer.workshops
              .where((workshop) => workshop.title
                  .toLowerCase()
                  .contains(event.search.toLowerCase()))
              .toList()));
    }
  }

  FutureOr<void> getWorkshopsMethod(
      GetWorkshopsEvent event, Emitter<UserHomeState> emit) async {
    try {
      emit(LoadingWorkshopsState());
      await supabaseLayer.getAllWorkshops();
      await supabaseLayer.getAllReviews();
      getBookedWorkshops();
      emit(
          SuccessWorkshopsState(workshops: dataLayer.workshops, search: false));
    } catch (e) {
      emit(ErrorWorkshopsState(msg: 'Bad Internet Connection :('));
    }
  }

  FutureOr<void> changeCategory(
      ChangeCategoryEvent event, Emitter<UserHomeState> emit) {
    emit(SuccessWorkshopsState(
        workshops: dataLayer.workshops,
        search: false,
        selectedCategory: event.category));
  }
}
