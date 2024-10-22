import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

final ThemeData myappTheme = ThemeData(
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
              color: Constants.mainOrange, fontSize: 12, fontFamily: "Poppins");
        }
        return const TextStyle(
            color: Colors.grey, fontSize: 12, fontFamily: "Poppins");
      }),
    ),
    tabBarTheme: const TabBarTheme(
      labelPadding: EdgeInsets.all(0),
      labelStyle: TextStyle(
        color: Constants.textColor,
        fontSize: 15,
        fontFamily: "Poppins",
      ),
      unselectedLabelStyle: TextStyle(
        color: Constants.textColor,
        fontSize: 15,
        fontFamily: "Poppins",
      ),
      dividerHeight: 0,
      indicator: BoxDecoration(
        color: Color.fromARGB(50, 190, 209, 42),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ));
