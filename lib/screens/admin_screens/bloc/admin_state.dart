part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class LoadingState extends AdminState {}

final class ErrorState extends AdminState {
  final String msg;
  ErrorState({required this.msg});
}

final class SuccessState extends AdminState {}