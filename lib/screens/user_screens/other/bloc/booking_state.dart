part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class ChangeQuantityState extends BookingState {
  final int quantity;
  final Workshop? specific;
  ChangeQuantityState({required this.quantity, this.specific});
}

final class SuccessState extends BookingState {}
