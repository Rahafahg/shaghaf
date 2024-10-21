import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  int currentScreen = 0;
  NavigationBloc() : super(NavigationInitial()) {
    on<SwitchScreenEvent>((event, emit) {
      currentScreen = event.targetPage;
      log(currentScreen.toString());
      emit(SwitchScreenState(targetPage: event.targetPage));
    });
  }
}
