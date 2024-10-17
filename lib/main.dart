import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/screens/other_screens/onboarding_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: "Poppins", fontSize: 40, fontWeight: FontWeight.w800, color: Constants.mainOrange),
          titleSmall: TextStyle(fontFamily: "Poppins", fontSize: 16, color: Constants.mainOrange)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const FirstScreen()
    );
  }
}
