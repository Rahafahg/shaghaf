part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

final class AddQuantityEvent extends BookingEvent {}

final class ReduceQuantityEvent extends BookingEvent {}

final class UpdateDayEvent extends BookingEvent {
  final Workshop specific;
  final String selectedDate;
  UpdateDayEvent({required this.specific, required this.selectedDate});
}