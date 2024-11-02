part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

final class FilterCategoryWorkshopsEvent extends CategoriesEvent {
  final CategoriesModel? category;
  final String? searchTerm;
  final String? date;
  final int? type;
  final int? ratingType;
  final RangeValues? range;
  FilterCategoryWorkshopsEvent({this.category, this.searchTerm, this.date, this.range, this.ratingType, this.type});
}

final class CategorySearchEvent extends CategoriesEvent {
  // final List<WorkshopGroupModel> workshops;
  final String searchTerm;
  final CategoriesModel category;
  CategorySearchEvent({required this.category,required this.searchTerm});
}

final class ChangePriceEvent extends CategoriesEvent {
  final RangeValues range;
  ChangePriceEvent({required this.range});
}

final class ResetFilterEvent extends CategoriesEvent {}

final class HandleDateEvent extends CategoriesEvent {
  final String date;
  HandleDateEvent({required this.date});
}

// final class FilterEvent extends CategoriesEvent {
//   final String? date;
//   final RangeValues? range;
//   FilterEvent({this.date, this.range});
// }

final class ChangeTypeEvent extends CategoriesEvent {
  final int index;
  ChangeTypeEvent({required this.index});
}

final class ChangeRatingEvent extends CategoriesEvent {
  final int index;
  ChangeRatingEvent({required this.index});
}