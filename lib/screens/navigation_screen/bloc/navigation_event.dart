part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

final class SwitchScreenEvent extends NavigationEvent {
  final int targetPage;
  SwitchScreenEvent({required this.targetPage});
}
