import 'dart:developer';
import 'dart:math' as mm;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  int quantity = 1;
  Workshop? chosenWorkshop;
  BookingBloc() : super(BookingInitial()) {
    on<GetBookingsEvent>((event, emit) async {
      if(GetIt.I.get<AuthLayer>().user != null) {
        await GetIt.I.get<SupabaseLayer>().getBookings();
      }
    });
    on<AddQuantityEvent>((event, emit) {
      emit(ChangeQuantityState(quantity: quantity = quantity + 1));
    });

    on<ReduceQuantityEvent>((event, emit) {
      emit(ChangeQuantityState(
          quantity: quantity != 1 ? quantity = quantity - 1 : 1));
    });

    on<UpdateDayEvent>((event, emit) {
      chosenWorkshop = event.specific;
      emit(ChangeQuantityState(
          quantity: quantity = 1, specific: event.specific));
    });

    on<SaveBookingEvent>((event, emit) async {
      String qr = mm.Random().nextInt(999999999).toString();
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
          GetIt.I.get<SupabaseLayer>().getBookings();
          await sendTicketToEmail(booking: booking, group: event.group, specific: event.workshop);
          emit(SuccessState(booking: booking));
        } else {
          log('Failed to save booking. Please try again.');
        }
      } catch (e) {
        log('Error saving booking: $e');
      }
    });
  }

  sendTicketToEmail(
      {required BookingModel booking,
      required WorkshopGroupModel group,
      required Workshop specific}) async {
    try {
      emailjs.send(
        dotenv.env['EMAILJS_SERVICE_ID']!,
        dotenv.env['EMAILJS_TEMPLATE_ID']!,
        {
          'booking_id': booking.qrCode,
          'booking_date': booking.bookingDate.toString(),
          'tickets': booking.numberOfTickets,
          'workshop_name': group.title,
          'workshop_date': specific.date,
          'from': specific.fromTime,
          'to': specific.toTime,
          'to_name': '${GetIt.I.get<AuthLayer>().user?.firstName} ${GetIt.I.get<AuthLayer>().user?.lastName}',
          'to_email': GetIt.I.get<AuthLayer>().user?.email,
          'link' : specific.isOnline ? specific.meetingUrl : 'https://www.google.com/maps/search/?api=1&query=${specific.latitude},${specific.longitude}'
        },
        emailjs.Options(
          publicKey: dotenv.env['EMAILJS_PUBLIC_KEY'],
          privateKey: dotenv.env['EMAILJS_PRIVATE_KEY'],
        ),
      );
    } catch (error) {
      log('eroreta : $error');
    }
  }
}
