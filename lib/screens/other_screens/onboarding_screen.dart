import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/other_screens/select_role_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/chapes/onboarding_chape.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<String>> phrases = [
      ["Discover".tr(), "the innovative community around you".tr()],
      ["Learn".tr(), "and improve your skills in many fields".tr()],
      ["Follow".tr(), "your passion wherever it might be".tr()]
    ];
    final key =
        GlobalKey<IntroductionScreenState>(); // to switch onboarding screen
    return Scaffold(
        body: IntroductionScreen(
            key: key,
            dotsContainerDecorator:
                const BoxDecoration(color: Color(0xffFFFCEB)),
            dotsDecorator: const DotsDecorator(
                activeColor: Constants.mainOrange, activeSize: Size(15, 15)),
            overrideNext: const SizedBox(height: 30),
            overrideDone: const SizedBox(height: 30),
            globalBackgroundColor: Colors.transparent,
            controlsMargin: EdgeInsets.zero,
            scrollPhysics:
                const NeverScrollableScrollPhysics(), // comment me to enable scroll
            pages: List.generate(3, (index) {
              return PageViewModel(
                  decoration: const PageDecoration(
                      fullScreen: true,
                      contentMargin: EdgeInsets.zero,
                      bodyFlex: 0),
                  useScrollView: false,
                  title: "",
                  image: Image.asset(
                    "assets/images/onboarding_pic${index + 1}.png",
                    width: context.getWidth(),
                    height: context.getHeight(),
                    fit: BoxFit.cover,
                  ),
                  bodyWidget: Stack(children: [
                    CustomPaint(
                      size: Size(
                          context.getWidth(), context.getHeight(divideBy: 2.3)),
                      painter: RPSCustomPainter(),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 41,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(phrases[index][0],
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  color: Constants.mainOrange)),
                          const SizedBox(height: 8),
                          Text(phrases[index][1],
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: Constants.mainOrange)),
                          const SizedBox(height: 50),
                          MainButton(
                            onPressed: () => index != 2
                                ? key.currentState?.next()
                                : context.push(
                                    screen: const SelectRoleScreen()),
                            text: index != 2 ? "Next".tr() : "Continue".tr(),
                            width: 290,
                            height: 45,
                          )
                        ],
                      ),
                    )
                  ]));
            })));
  }
}
