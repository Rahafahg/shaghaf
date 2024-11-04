part of 'theme_bloc.dart';

@immutable
// sealed class ThemeState {}

// final class ThemeInitial extends ThemeState {}

// Define your state
class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  factory ThemeState.initial() {
    return ThemeState(themeMode: ThemeMode.light);
  }

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}


// class ThemeState {
//   final ThemeMode themeMode;

//   ThemeState({required this.themeMode});
  
//   factory ThemeState.initial() {
//     return ThemeState(themeMode: ThemeMode.light);
//   }

//   ThemeState copyWith({ThemeMode? themeMode}) {
//     return ThemeState(
//       themeMode: themeMode ?? this.themeMode,
//     );
//   }
// }


// class ThemeState {
//   final ThemeMode themeMode;

//   ThemeState({required this.themeMode});
  
//   // Provides an initial state with light mode
//   factory ThemeState.initial() {
//     return ThemeState(themeMode: ThemeMode.light);
//   }

//   // Method to toggle between light and dark theme
//   ThemeState copyWith({ThemeMode? themeMode}) {
//     return ThemeState(
//       themeMode: themeMode ?? this.themeMode,
//     );
//   }
// }
