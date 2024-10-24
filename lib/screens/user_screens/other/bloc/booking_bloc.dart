import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  int quantity = 1;
  BookingBloc() : super(BookingInitial()) {
    on<AddQuantityEvent>((event, emit) {
      emit(ChangeQuantityState(quantity: quantity = quantity + 1));
    });

    on<ReduceQuantityEvent>((event, emit) {
      emit(ChangeQuantityState(
          quantity: quantity != 1 ? quantity = quantity - 1 : 1));
    });

    on<UpdateDayEvent>((event, emit) {
      emit(ChangeQuantityState(
          quantity: quantity = 1, specific: event.specific));
    });

    on<SaveBookingEvent>((event, emit) async {
      String qr = Random().nextInt(999999999).toString();
      double price = event.workshop.price * event.quantity;

      try {
        final bookingAsMap = await GetIt.I.get<SupabaseLayer>().saveBooking(
              numberOfTickets: event.quantity,
              qr: qr,
              workshop: event.workshop,
              totalPrice: price,
            );
        if (bookingAsMap != null) {
          final booking = BookingModel.fromJson(bookingAsMap);
          emit(SuccessState(booking: booking));
        } else {
          print('Failed to save booking. Please try again.');
        }
      } catch (e) {
        print('Error saving booking: $e');
      }
    });
  }
}
