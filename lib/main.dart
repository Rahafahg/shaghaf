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
          // onboarding title
          titleLarge: TextStyle(fontFamily: "Poppins", fontSize: 40, fontWeight: FontWeight.w800, color: Constants.mainOrange),
          // onboarding text
          titleSmall: TextStyle(fontFamily: "Poppins", fontSize: 16, color: Constants.mainOrange),
          // body & btn text
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w600),
          // role card text
          bodySmall: TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w600)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const FirstScreen()
    );
  }
}
