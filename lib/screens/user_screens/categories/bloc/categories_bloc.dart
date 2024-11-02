import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final TextEditingController dateController = TextEditingController();
  List<WorkshopGroupModel> workshops = [];
  List<String> types = ['All', 'In-Site', 'Online'];
  String selectedType = 'All';
  List<String> ratingsList = ['All', 'Top-Rated'];
  String ratingType = 'All';
  double minPrice = 0;
  double maxPrice = 500;

  CategoriesBloc() : super(CategoriesInitial()) {
    // on<FilterCategoryWorkshopsEvent>((event, emit) {
      // if(event.date!=null) {
      //   dateController.text = event.date!;
      // }
      // log(event.category!.categoryName);
      // log('message');
      // log(dateController.text);
      // log('one more');
      // try {
      //   final categoryWorkshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == event.category!.categoryId).toList();
      // } catch (e) {
      //   log(e.toString());
      // }
      // log(event.category?.categoryName ?? 'no category');
      // log(event.type?.toString() ?? 'no type');
      // log(event.date?.toString() ?? 'no date');
      // log(event.range?.start.toString() ?? 'no start');
      // log(event.range?.end.toString() ?? 'no end');
      // log(event.ratingType?.toString() ?? 'no rating type');
      // log(event.searchTerm ?? 'no search term');
      // selectedType = event.type != null ? types[event.type!] : 'All';
      // log('----------bloc now----------');
      // log(selectedType);
      // emit(ShowCategoryWorkshopsState(workshops: []));
      // emit(ShowCategoryWorkshopsState(workshops: workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.date==dateController.text)).toList()));
    // });
    on<CategorySearchEvent>(categorySearchMethod);
    on<ChangePriceEvent>(handlePriceMethod);
    on<ChangeTypeEvent>(handelTypeMethod); // Calls handelTypeMethod only once
    on<HandleDateEvent>((event, emit) {
      dateController.text = event.date;
      // log(event.date);
      // log(dateController.text);
      // bool isOnline = selectedType == 'Online';
      emit(ShowCategoryWorkshopsState(
          workshops: workshops
              .where((workshopGroup) => workshopGroup.workshops.any(
                  (workshop) =>
                      // (workshop.isOnline == isOnline) &&
                      workshop.date == event.date &&
                      workshop.price <= maxPrice &&
                      workshop.price >= minPrice))
              .toList()));
    });
    on<ResetFilterEvent>(resetFilterMethod);
    on<ChangeRatingEvent>((event, emit) {
      ratingType = ratingsList[event.index];
      emit(ShowCategoryWorkshopsState(workshops: workshops));
    });
  }

  FutureOr<void> resetFilterMethod(ResetFilterEvent event, Emitter<CategoriesState> emit) {
    dateController.value = TextEditingValue.empty;
    minPrice = 0;
    maxPrice = 500;
    selectedType = 'All';
    ratingType = 'All';
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> handlePriceMethod(
      ChangePriceEvent event, Emitter<CategoriesState> emit) {
    minPrice = event.range.start;
    maxPrice = event.range.end;
    log(minPrice.toString());
    log(maxPrice.toString());
    if (dateController.text.isNotEmpty) {
      emit(ShowCategoryWorkshopsState(
          workshops: workshops
              .where((workshopGroup) => workshopGroup.workshops.any(
                  (workshop) =>
                      workshop.date == dateController.text &&
                      workshop.price <= maxPrice &&
                      workshop.price >= minPrice))
              .toList()));
    } else {
      emit(ShowCategoryWorkshopsState(
          workshops: workshops
              .where((workshopGroup) => workshopGroup.workshops.any(
                  (workshop) =>
                      workshop.price >= minPrice && workshop.price <= maxPrice))
              .toList()));
    }
  }

  FutureOr<void> categorySearchMethod(
      CategorySearchEvent event, Emitter<CategoriesState> emit) {
    log('here am i');
    final categoryWorkshops = GetIt.I
        .get<DataLayer>()
        .workshops
        .where((workshop) => workshop.categoryId == event.category.categoryId)
        .toList();
    if (event.searchTerm == '') {
      workshops = categoryWorkshops;
      emit(ShowCategoryWorkshopsState(workshops: categoryWorkshops));
    } else {
      workshops = categoryWorkshops
          .where((workshop) => workshop.title
              .toLowerCase()
              .contains(event.searchTerm.toLowerCase()))
          .toList();
      emit(ShowCategoryWorkshopsState(workshops: workshops));
    }
  }

  FutureOr<void> handelTypeMethod(ChangeTypeEvent event, Emitter<CategoriesState> emit) {
    selectedType = types[event.index];
    log("Selected Type: $selectedType");
    log(dateController.text);
    List<WorkshopGroupModel> filteredWorkshops = workshops;

    if (selectedType != 'All') {
      bool isOnline = selectedType == 'Online';
      if(dateController.text.isEmpty) {
        filteredWorkshops = filteredWorkshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline)).toList();
      }
      if(dateController.text.isNotEmpty) {
        filteredWorkshops = filteredWorkshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline && dateController.text == workshop.date)).toList();
      }
      // bool hasMatchingType;
      // filteredWorkshops = filteredWorkshops.where((workshopGroup) {
      //   if(dateController.text.isEmpty) {
      //     hasMatchingType = workshopGroup.workshops.any((workshop) => workshop.isOnline == isOnline);
      //   }
      //   else {
      //     hasMatchingType = workshopGroup.workshops.any((workshop) => workshop.isOnline == isOnline && workshop.date == dateController.text);
      //   }
      //   if (!hasMatchingType) {
      //     log("Excluding workshopGroup: No workshops of type $selectedType found in this group.");
      //   }
      //   return hasMatchingType;
      // }).toList();
      // filteredWorkshops = filteredWorkshops.where((workshopGroup) {
      //   bool hasMatchingType = workshopGroup.workshops.any((workshop) =>
      //       workshop.isOnline == isOnline &&
      //       workshop.date == dateController.text);
      //   if (!hasMatchingType) {
      //     log("Excluding workshopGroup: No workshops of type $selectedType found in this group.");
      //   }
      //   return hasMatchingType;
      // }).toList();
    }
    emit(ShowCategoryWorkshopsState(workshops: filteredWorkshops));
  }
}