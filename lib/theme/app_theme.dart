import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

ThemeData myappTheme(BuildContext context, bool isDarkMode) {
  // Define light theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: context.locale.languageCode == 'en' ? 'Poppins' : 'ReadexPro',
    scaffoldBackgroundColor: Constants.backgroundColor,
    primaryColor: Constants.mainOrange,
    colorScheme: const ColorScheme.light(
      primary: Constants.mainOrange,
      onPrimary: Colors.white,
      secondary: Constants.lightGreen,
      onSecondary: Constants.textColor,
      //  background: Constants.backgroundColor,
      primaryContainer: Constants.profileColor,
      onBackground: Constants.textColor,
      surface: Constants.cardColor,
      onSurface: Constants.textColor,
      surfaceTint: Constants.ticketCardColor
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Constants.textColor),
      bodyMedium: TextStyle(color: Constants.lightTextColor),
      titleLarge: TextStyle(color: Constants.textColor),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      indicatorShape: LinearBorder.top(
          side: const BorderSide(width: 2, color: Constants.mainOrange)),
      height: 53,
      labelTextStyle: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return const TextStyle(
              color: Constants.mainOrange, fontSize: 12, fontFamily: "Poppins");
        }
        return const TextStyle(
            color: Colors.grey, fontSize: 12, fontFamily: "Poppins");
      }),
    ),
    tabBarTheme: const TabBarTheme(
      dividerColor: Colors.transparent,
    ),
    dividerColor: Constants.dividerColor,
    cardColor: Constants.cardColor,
    iconTheme: const IconThemeData(color: Constants.mainOrange),
  );

  // Define dark theme
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: context.locale.languageCode == 'en' ? 'Poppins' : 'ReadexPro',
    scaffoldBackgroundColor: const Color(0xff181818),
    primaryColor: Constants.mainOrange,
    colorScheme: ColorScheme.dark(
      primary: const Color.fromARGB(255, 225, 109, 59),
      onPrimary: Colors.pink,
      secondary: Constants.lightGreen,
      onSecondary: Colors.white,
      primaryContainer: const Color(0xff170d07),
      //  background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.grey[850]!,
      onSurface: Colors.white,
      surfaceTint:  Colors.grey[850]!
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey[300]),
      titleLarge: const TextStyle(color: Colors.white),
      
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.transparent,
      surfaceTintColor: Colors.black,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      indicatorShape: LinearBorder.top(
          side: const BorderSide(width: 2, color: Constants.mainOrange)),
      height: 53,
      labelTextStyle: WidgetStateProperty.resolveWith((state) {
        if (state.contains(MaterialState.selected)) {
          return const TextStyle(
              color: Constants.mainOrange, fontSize: 12, fontFamily: "Poppins");
        }
        return const TextStyle(
            color: Colors.grey, fontSize: 12, fontFamily: "Poppins");
      }),
    ),
    tabBarTheme: const TabBarTheme(
      dividerColor: Colors.transparent,
    ),
    dividerColor: Constants.dividerColor,
    cardColor: Colors.grey[850],
    iconTheme: const IconThemeData(color: Constants.lightOrange),
  );

  // Return light or dark theme based on isDarkMode
  return isDarkMode ? darkTheme : lightTheme;
}
