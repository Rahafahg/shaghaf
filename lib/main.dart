import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/screens/other_screens/onboarding_screen.dart';
import 'package:shaghaf/screens/other_screens/select_categories_screen.dart';
import 'package:shaghaf/screens/user_screens/user_home_screen.dart';
import 'package:shaghaf/services/setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
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
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w600),
          // role card text
          displaySmall: TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w600),
          // error msg in login
          bodySmall: TextStyle(fontSize: 14, fontFamily: "Poppins"),
        )
      ),
      debugShowCheckedModeBanner: false,
      home: GetIt.I.get<AuthLayer>().user != null ? const SelectCategoriesScreen() : const OnboardingScreen()
    );
  }
}