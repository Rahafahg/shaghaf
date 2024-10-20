import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
      debugShowCheckedModeBanner: false,
      home: GetIt.I.get<AuthLayer>().user != null ?
        GetIt.I.get<AuthLayer>().didChooseFav ? const UserHomeScreen()
        : const SelectCategoriesScreen()
      : const OnboardingScreen()
    );
  }
}