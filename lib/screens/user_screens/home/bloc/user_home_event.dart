part of 'user_home_bloc.dart';

@immutable
sealed class UserHomeEvent {}

final class GetWorkshopsEvent extends UserHomeEvent {}

final class HomeSearchEvent extends UserHomeEvent {
  final String search;
  HomeSearchEvent({required this.search});
}