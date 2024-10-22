import 'package:get_it/get_it.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class DataLayer {
  List<CategoriesModel> categories = [];
  List<WorkshopGroupModel> workshops = [];
  WorkshopGroupModel? workshopOfTheWeek;
  Map<String, List<WorkshopGroupModel>> workshopsByCategory = {};
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
