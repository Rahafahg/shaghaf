import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

ThemeData myappTheme(BuildContext context) {
  final ThemeData myappTheme = ThemeData(
      fontFamily: context.locale.languageCode == 'en' ? 'Poppins' : 'ReadexPro',
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStateColor.transparent,
        indicatorShape: LinearBorder.top(
            side: const BorderSide(width: 2, color: Constants.mainOrange)),
        height: 53,
        backgroundColor: Colors.white,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Constants.mainOrange,
              fontSize: 12,
            );
          }
          return const TextStyle(color: Colors.grey, fontSize: 12);
        }),
      ),
      tabBarTheme: const TabBarTheme(
        dividerHeight: 0,
      ));
  return myappTheme;
}
