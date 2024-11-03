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
  List<String> types = ['All', 'In-Site', 'Online'];
  String selectedType = 'All';
  List<String> ratingsList = ['All', 'Top-Rated'];
  String ratingType = 'All';
  double minPrice = 0;
  double maxPrice = 1000;
  CategoriesModel? selectedCategory;

  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategorySearchEvent>(categorySearchMethod);
    on<ResetFilterEvent>(resetFilterMethod);
    on<HandleDateEvent>(handleDateMethod);
    on<ChangeTypeEvent>(handelTypeMethod);
    on<ChangeRatingEvent>(handleRatingMethod);
    on<ChangePriceEvent>(handlePriceMethod);
  }

  FutureOr<void> categorySearchMethod(CategorySearchEvent event, Emitter<CategoriesState> emit) {
    dateController.value = TextEditingValue.empty;
    minPrice = 0;
    maxPrice = 1000;
    selectedType = 'All';
    ratingType = 'All';
    selectedCategory = event.category;
    final categoryWorkshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == event.category.categoryId).toList();
    if (event.searchTerm == '') {
      workshops = categoryWorkshops;
      emit(ShowCategoryWorkshopsState(workshops: categoryWorkshops));
    }
    else {
      workshops = categoryWorkshops.where((workshop) => workshop.title.toLowerCase().contains(event.searchTerm.toLowerCase())).toList();
      emit(ShowCategoryWorkshopsState(workshops: workshops));
    }
  }

  FutureOr<void> resetFilterMethod(ResetFilterEvent event, Emitter<CategoriesState> emit) {
    workshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == selectedCategory?.categoryId).toList();
    dateController.value = TextEditingValue.empty;
    minPrice = 0;
    maxPrice = 1000;
    selectedType = 'All';
    ratingType = 'All';
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> handleDateMethod(HandleDateEvent event, Emitter<CategoriesState> emit) {
    dateController.text = event.date;
    workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) =>workshop.date == event.date && workshop.price <= maxPrice &&workshop.price >= minPrice)).toList();
    if(selectedType == 'All') {
      if(ratingType == 'All') {
        workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) =>workshop.date == event.date && workshop.price <= maxPrice &&workshop.price >= minPrice)).toList();
      }
      if(ratingType!="All") {
        workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
        workshops = workshops.reversed.toList();
      }
    }
    if(selectedType != "All") {
      bool isOnline = selectedType == "Online";
      workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline)).toList();
      if(ratingType=='All') {
        workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline)).toList();
      }
      if(ratingType!="All") {
        workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
        workshops = workshops.reversed.toList();
      }
    }
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> handelTypeMethod(ChangeTypeEvent event, Emitter<CategoriesState> emit) {
    selectedType = types[event.index];
    workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
    if (selectedType != 'All') {
      bool isOnline = selectedType == 'Online';
      if(dateController.text.isEmpty) {
        workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline && workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        if(ratingType=="All") {
          workshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == selectedCategory?.categoryId).toList();
          workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline && workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        }
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
      }
      else {
        workshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == selectedCategory?.categoryId).toList();
        workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline && dateController.text == workshop.date && workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        if(ratingType=="All") {
          workshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == selectedCategory?.categoryId).toList();
          workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.isOnline==isOnline && dateController.text == workshop.date && workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
          log(workshops.length.toString());
        }
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
      }
    }
    if(selectedType=='All') {
      if(dateController.text.isEmpty) {
        workshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == selectedCategory?.categoryId).toList();
        workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.price<=maxPrice && workshop.price>=minPrice)).toList();
        if(ratingType=="All") {
          workshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == selectedCategory?.categoryId).toList();
          workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=>workshop.price<=maxPrice && workshop.price>=minPrice)).toList();
        }
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
      }
      if(dateController.text.isNotEmpty) {
        workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=> dateController.text == workshop.date && workshop.price<=maxPrice && workshop.price>=minPrice)).toList();
        if(ratingType=="All") {
          workshops = workshops.where((workshopGroup)=>workshopGroup.workshops.any((workshop)=> dateController.text == workshop.date && workshop.price<=maxPrice && workshop.price>=minPrice)).toList();
        }
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
      }
    }
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> handleRatingMethod(ChangeRatingEvent event, Emitter<CategoriesState> emit) {
    ratingType = ratingsList[event.index];
    if(ratingType!='All') {
      workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
      workshops = workshops.reversed.toList();
    }
    if(ratingType=='All') {
      if(dateController.text.isEmpty) {
        if(selectedType=='All') {
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        }
        if(selectedType!="All") {
          bool isOnline = selectedType == "Online";
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice && workshop.isOnline == isOnline)).toList();
        }
      }
      if(dateController.text.isNotEmpty) {
        if(selectedType=='All') {
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice && workshop.date==dateController.text)).toList();
        }
        if(selectedType!="All") {
          bool isOnline = selectedType == 'Online';
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice && workshop.date==dateController.text && workshop.isOnline==isOnline)).toList();
        }
      }
    }
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }

  FutureOr<void> handlePriceMethod(ChangePriceEvent event, Emitter<CategoriesState> emit) {
    minPrice = event.range.start;
    maxPrice = event.range.end;
    if (dateController.text.isNotEmpty) {
      if(selectedType!='All') {
        bool isOnline = selectedType == 'Online';
        workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) =>workshop.date == dateController.text &&workshop.price <= maxPrice && workshop.price >= minPrice && workshop.isOnline==isOnline)).toList();
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
        if(ratingType=='All') {
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) =>workshop.date == dateController.text &&workshop.price <= maxPrice && workshop.price >= minPrice && workshop.isOnline==isOnline)).toList();
        }
      }
      if(selectedType=="All") {
        workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) =>workshop.date == dateController.text &&workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
        if(ratingType=="All") {
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) =>workshop.date == dateController.text &&workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        }
      }
    }
    if(dateController.text.isEmpty) {
      if(selectedType!='All') {
        bool isOnline = selectedType == 'Online';
        workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice && workshop.isOnline==isOnline)).toList();
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
        if(ratingType=="All") {
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice && workshop.isOnline==isOnline)).toList();
        }
      }
      if(selectedType=="All") {
        workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        if(ratingType!="All") {
          workshops.sort((w1, w2)=>w1.rating.compareTo(w2.rating));
          workshops = workshops.reversed.toList();
        }
        if(ratingType=="All") {
          workshops = workshops.where((workshopGroup) => workshopGroup.workshops.any((workshop) => workshop.price <= maxPrice && workshop.price >= minPrice)).toList();
        }
      }
    }
    emit(ShowCategoryWorkshopsState(workshops: workshops));
  }
}