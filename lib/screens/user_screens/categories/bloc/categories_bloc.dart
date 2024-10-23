import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
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
    // on<FilterEvent>((event, emit) {
    //   log('filtering');
    //   if(event.date != null) {
    //     dateController.text = event.date!;
    //     log(dateController.text);
    //   }
    //   if(event.range != null) {
    //     minPrice = event.range!.start;
    //     maxPrice = event.range!.end;
    //   }
    //   ShowCategoryWorkshopsState(workshops: workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop){
    //     log('message');
    //     return workshop.date == dateController.text;
    //   })).toList());
    // });
    on<HandleDateEvent>((event, emit) {
      dateController.text = event.date;
      emit(ShowCategoryWorkshopsState(workshops: workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.date==event.date && workshop.price <= maxPrice && workshop.price >= minPrice)).toList()));
    });
    on<ResetFilterEvent>(resetFilterMethod);
  }

  FutureOr<void> resetFilterMethod(ResetFilterEvent event, Emitter<CategoriesState> emit) {
    dateController.value = TextEditingValue.empty;
    minPrice = 0;
    maxPrice = 500;
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> handlePriceMethod(ChangePriceEvent event, Emitter<CategoriesState> emit) {
    minPrice = event.range.start;
    maxPrice = event.range.end;
    log(minPrice.toString());
    log(maxPrice.toString());
    if(dateController.text.isNotEmpty) {
      emit(ShowCategoryWorkshopsState(workshops: workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.date==dateController.text && workshop.price <= maxPrice && workshop.price >= minPrice)).toList()));
    }
    else {
      emit(ShowCategoryWorkshopsState(workshops: workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.price>=minPrice&&workshop.price<=maxPrice)).toList()));
    }
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
