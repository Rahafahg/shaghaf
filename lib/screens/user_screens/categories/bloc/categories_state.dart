part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class ShowCategoryWorkshopsState extends CategoriesState {
  final List<WorkshopGroupModel> workshops;
  ShowCategoryWorkshopsState({required this.workshops});
}

final class UpdatePriceState extends CategoriesState {}