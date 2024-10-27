import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class DataLayer {
  List<CategoriesModel> categories = [];
  List<WorkshopGroupModel> workshops = [];
  WorkshopGroupModel? workshopOfTheWeek;
  Map<String, List<WorkshopGroupModel>> workshopsByCategory = {};
  List<BookingModel> bookings = [];
  List<Workshop> bookedWorkshops = [];
  List<WorkshopGroupModel> orgWorkshops = [];
}

getOrgWorkshops() {
  List<WorkshopGroupModel> temp = [];
  for (var workshopGroup in GetIt.I.get<DataLayer>().workshops) {
    if(workshopGroup.organizerId == GetIt.I.get<AuthLayer>().organizer!.organizerId) {
      temp.add(workshopGroup);
    }
  }
  GetIt.I.get<DataLayer>().orgWorkshops = temp;
  log("here here today");
  log(GetIt.I.get<DataLayer>().orgWorkshops.length.toString());
}

List<Workshop> getBookedWorkshops() {
  List<Workshop> bookedWorkshops = [];
    for(var booking in GetIt.I.get<DataLayer>().bookings) {
      for (var workshopGroup in GetIt.I.get<DataLayer>().workshops) {
        for (var workshop in workshopGroup.workshops) {
          if(workshop.workshopId == booking.workshopId) {
            bookedWorkshops.add(workshop);
          }
        }
      }
    }
    log(bookedWorkshops.map((b)=>b.toJson()).toString());
    GetIt.I.get<DataLayer>().bookedWorkshops = bookedWorkshops;
    return bookedWorkshops;
}

Map<String, List<WorkshopGroupModel>> groupworkshopsByCategory(
    List<WorkshopGroupModel> workshops) {
  Map<String, List<WorkshopGroupModel>> groupedItems = {};
  for (var workshop in workshops) {
    String category = GetIt.I
        .get<DataLayer>()
        .categories
        .firstWhere((category) => category.categoryId == workshop.categoryId)
        .categoryName;
    if (!groupedItems.containsKey(category)) {
      groupedItems[category] = [];
    }
    groupedItems[category]!.add(workshop);
  }
  return groupedItems;
}
