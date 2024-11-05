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
    colorScheme: ColorScheme.light(
        onPrimaryFixedVariant: Constants.appGreyColor,
        onTertiary: Colors.grey[400]!,
        primary: Constants.mainOrange,
        onPrimary: Colors.white,
        onPrimaryFixed: Colors.white,
        secondary: Constants.mainOrange,
        onSecondary: Constants.textColor,
        onPrimaryContainer: Constants.ticketCardColor,
        onSecondaryContainer: Colors.white,
        //  background: Constants.backgroundColor,
        primaryContainer: Constants.profileColor,
        onBackground: Constants.textColor,
        surface: Constants.profileColor,
        onInverseSurface: Constants.cardColor,
        onSurface: Constants.textColor,
        surfaceTint: Constants.ticketCardColor),
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
        onPrimaryFixedVariant: const Color.fromARGB(255, 99, 95, 95),
        onPrimaryFixed: Colors.grey[850]!,
        onTertiary: Colors.grey[800]!,
        primary: const Color.fromARGB(255, 225, 109, 59),
        onPrimary: Colors.white,
        secondary: Constants.lightOrange,
        onSecondary: Colors.white,
        primaryContainer: const Color(0xff170d07),
        onPrimaryContainer: const Color.fromARGB(255, 188, 173, 167),
        onSecondaryContainer: Colors.grey[850]!,
        //  background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.grey[850]!,
        onInverseSurface: Colors.grey[850]!,
        onSurface: Colors.white,
        surfaceTint: Colors.grey[850]!),
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
