import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class DataLayer {
  List<CategoriesModel> categories = [];
  List<WorkshopGroupModel> workshops = [];
  WorkshopGroupModel? workshopOfTheWeek;
}
