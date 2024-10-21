import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

final ThemeData myappTheme = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
  indicatorColor: Colors.transparent,
  
  overlayColor: WidgetStateColor.transparent,
  indicatorShape: LinearBorder.top(
      side: const BorderSide(width: 2, color: Constants.mainOrange)),
  backgroundColor: Colors.white,
  labelTextStyle: WidgetStateProperty.resolveWith((state) {
    if (state.contains(WidgetState.selected)) {
      return const TextStyle(color: Constants.mainOrange);
    }
    return const TextStyle(color: Colors.grey);
  }),
));
