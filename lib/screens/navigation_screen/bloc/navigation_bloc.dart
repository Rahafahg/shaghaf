import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shaghaf/screens/user_screens/profile_screen.dart';
import 'package:shaghaf/screens/user_screens/user_home_screen.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  int currentScreen = 0;
  List<Widget> screens = [
    const UserHomeScreen(),
    const Placeholder(),
    const Placeholder(),
    const ProfileScreen()
  ];
  NavigationBloc() : super(NavigationInitial()) {
    on<SwitchScreenEvent>((event, emit) {
      currentScreen = event.targetPage;
      emit(SwitchScreenState());
    });
  }
}
