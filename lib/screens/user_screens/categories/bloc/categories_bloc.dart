import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final TextEditingController dateController = TextEditingController();
  List<WorkshopGroupModel> workshops = [];
  double minPrice = 0;
  double maxPrice = 500;
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategorySearchEvent>(categorySearchMethod);
    on<ChangePriceEvent>(handlePriceMethod);
  }

  FutureOr<void> handlePriceMethod(ChangePriceEvent event, Emitter<CategoriesState> emit) {
    minPrice = event.range.start;
    maxPrice = event.range.end;
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> categorySearchMethod(CategorySearchEvent event, Emitter<CategoriesState> emit) {
    log('here am i');
    final categoryWorkshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == event.category.categoryId).toList();
    if(event.searchTerm=='') {
      workshops = categoryWorkshops;
      emit(ShowCategoryWorkshopsState(workshops: categoryWorkshops));
    }
    else {
      workshops = categoryWorkshops.where((workshop)=>workshop.title.contains(event.searchTerm)).toList();
      emit(ShowCategoryWorkshopsState(workshops: workshops));
    }
  }
}
