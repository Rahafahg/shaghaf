part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

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