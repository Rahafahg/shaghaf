import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shaghaf/screens/user_screens/home/user_home_screen.dart';
import 'package:shaghaf/screens/user_screens/profile_screen.dart';

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
