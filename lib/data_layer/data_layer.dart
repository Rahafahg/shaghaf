import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class DataLayer {
  List<CategoriesModel> categories = [];                             // all workshops categories
  List<WorkshopGroupModel> workshops = [];                           // available workshops
  List<WorkshopGroupModel> allWorkshops = [];                        // all workshops (including old)
  WorkshopGroupModel? workshopOfTheWeek;                             // randomly chosen to attract users
  Map<String, List<WorkshopGroupModel>> workshopsByCategory = {};    // workshops of each category
  List<BookingModel> bookings = [];                                  // all user bookings
  List<Workshop> bookedWorkshops = [];                               // all workshops being booked by user
  List<WorkshopGroupModel> orgWorkshops = [];                        // all organizer workshops
}

// function to get organizer workshops
getOrgWorkshops() {
  List<WorkshopGroupModel> temp = [];
  for (var workshopGroup in GetIt.I.get<DataLayer>().allWorkshops) {
    if(workshopGroup.organizerId == GetIt.I.get<AuthLayer>().organizer!.organizerId) {
      temp.add(workshopGroup);
    }
  }
  GetIt.I.get<DataLayer>().orgWorkshops = temp;
  log('org workshops : ${GetIt.I.get<DataLayer>().orgWorkshops.length}');
}

// function to get booked workshops
List<Workshop> getBookedWorkshops() {
  List<Workshop> bookedWorkshops = [];
  for(var booking in GetIt.I.get<DataLayer>().bookings) {
    for (var workshopGroup in GetIt.I.get<DataLayer>().allWorkshops) {
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

// function to order workshops by category
Map<String, List<WorkshopGroupModel>> groupworkshopsByCategory(List<WorkshopGroupModel> workshops) {
  Map<String, List<WorkshopGroupModel>> groupedItems = {};
  for (var workshop in workshops) {
    String category = GetIt.I.get<DataLayer>().categories.firstWhere((category) => category.categoryId == workshop.categoryId).categoryName;
    if (!groupedItems.containsKey(category)) {
      groupedItems[category] = [];
    }
    groupedItems[category]!.add(workshop);
  }
  return groupedItems;
}