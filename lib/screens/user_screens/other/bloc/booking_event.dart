part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

final class AddQuantityEvent extends BookingEvent {}

final class ReduceQuantityEvent extends BookingEvent {}