import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/navigation_screen/navigation_screen.dart';
import 'package:shaghaf/screens/other_screens/onboarding_screen.dart';
import 'package:shaghaf/screens/other_screens/select_categories_screen.dart';
import 'package:shaghaf/services/setup.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shaghaf/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myappTheme,
      debugShowCheckedModeBanner: false,
      home: GetIt.I.get<AuthLayer>().user != null
      ? GetIt.I.get<AuthLayer>().didChooseFav
        ? const NavigationScreen()
        : const SelectCategoriesScreen()
      : GetIt.I.get<AuthLayer>().onboarding ? const LoginScreen() : const OnboardingScreen()
    );
  }
}