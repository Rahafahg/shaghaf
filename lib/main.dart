import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/navigation_screen/navigation_screen.dart';
import 'package:shaghaf/screens/navigation_screen/organizer_navigation.dart';
import 'package:shaghaf/screens/other_screens/onboarding_screen.dart';
import 'package:shaghaf/screens/other_screens/select_categories_screen.dart';
import 'package:shaghaf/services/setup.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shaghaf/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setup();
  runApp(EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: Locale('ar', 'SA'),
          child: MainApp())
      //   DevicePreview(
      //   enabled: false,
      //   builder: (context) => const MainApp(),
      // )
      );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: myappTheme,
        debugShowCheckedModeBanner: false,
        home: GetIt.I.get<AuthLayer>().organizer != null
            ? const OrgNavigationScreen()
            : GetIt.I.get<AuthLayer>().user != null
                ? GetIt.I.get<AuthLayer>().didChooseFav
                    ? const NavigationScreen()
                    : const SelectCategoriesScreen()
                : GetIt.I.get<AuthLayer>().onboarding
                    ? const LoginScreen()
                    : const OnboardingScreen());
  }
}
