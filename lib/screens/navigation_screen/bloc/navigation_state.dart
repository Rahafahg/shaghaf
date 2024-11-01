part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class NavigationInitial extends NavigationState {}

final class SwitchScreenState extends NavigationState {
  final int? targetPage;
  SwitchScreenState({this.targetPage});
}