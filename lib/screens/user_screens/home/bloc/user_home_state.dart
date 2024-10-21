part of 'user_home_bloc.dart';

@immutable
sealed class UserHomeState {}

final class UserHomeInitial extends UserHomeState {}

final class DataDoneState extends UserHomeState {
  final List<WorkshopModel> workshops;
  DataDoneState({required this.workshops});
}