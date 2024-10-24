part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

final class AddQuantityEvent extends BookingEvent {}

final class ReduceQuantityEvent extends BookingEvent {}

final class SaveBookingEvent extends BookingEvent {
  final Workshop workshop;
  final int quantity;
  SaveBookingEvent({required this.workshop,required this.quantity});
}
