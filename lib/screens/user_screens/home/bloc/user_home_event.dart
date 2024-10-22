part of 'user_home_bloc.dart';

@immutable
sealed class UserHomeEvent {}

final class GetWorkshopsEvent extends UserHomeEvent {}

final class ChangeCategoryEvent extends UserHomeEvent {
  final String category;
  ChangeCategoryEvent({required this.category});
}

final class HomeSearchEvent extends UserHomeEvent {
  final String search;
  HomeSearchEvent({required this.search});
}
