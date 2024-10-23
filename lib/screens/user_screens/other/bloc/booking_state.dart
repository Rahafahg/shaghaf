part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class ChangeQuantityState extends BookingState {
  final int quantity;

  ChangeQuantityState({required this.quantity});
}
