part of 'user_home_bloc.dart';

@immutable
sealed class UserHomeState {}

final class UserHomeInitial extends UserHomeState {}

final class LoadingWorkshopsState extends UserHomeState {}

final class ErrorWorkshopsState extends UserHomeState {
  final String msg;
  ErrorWorkshopsState({required this.msg});
}

final class SuccessWorkshopsState extends UserHomeState {
  final List<WorkshopGroupModel> workshops;
  final bool search;
  final String? searchTerm;
  final String? selectedCategory;
  SuccessWorkshopsState({required this.search, required this.workshops, this.selectedCategory, this.searchTerm});
}