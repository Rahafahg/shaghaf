import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   ThemeBloc() : super(ThemeState.initial());

//   @override
//   Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
//     if (event is ToggleThemeEvent) {
//       // Toggle the theme mode between light and dark
//       final newThemeMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//       yield state.copyWith(themeMode: newThemeMode);
//     }
//   }
// }
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ToggleThemeEvent>((event, emit) {
      final newThemeMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      emit(state.copyWith(themeMode: newThemeMode));
    });
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'theme_event.dart';
// import 'theme_state.dart';

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   ThemeBloc() : super(ThemeState.initial());

//   @override
//   Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
//     if (event is ToggleThemeEvent) {
//       // Toggle between light and dark modes
//       final newThemeMode =
//           state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//       yield state.copyWith(themeMode: newThemeMode);
//     }
//   }
// }
