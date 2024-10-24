import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
      log('message');
      emit(ChangeQuantityState(quantity: 1, specific: event.specific));
    });
  }
}
