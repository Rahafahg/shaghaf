import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/add_workshop_screen.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
import 'package:shaghaf/screens/organizer_screens/home/organizer_home_screen.dart';
import 'package:shaghaf/screens/organizer_screens/profile/bloc/organizer_profile_bloc.dart';
import 'package:shaghaf/screens/organizer_screens/profile/organizer_profile_screen.dart';
import 'package:sizer/sizer.dart';

class OrgNavigationScreen extends StatelessWidget {
  const OrgNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> tabsIcons = [
      HugeIcons.strokeRoundedHome09,
      HugeIcons.strokeRoundedUser
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AddWorkshopBloc()..add(GetOrgWorkshopsEvent())),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => OrganizerProfileBloc()),
        //other blocs can be added here
      ],
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: FloatingActionButton(
              backgroundColor: Constants.lightOrange,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: () => context.push(
                  screen: const AddWorkshopScreen(
                isSingleWorkShope: false,
              )),
              child: const Icon(Icons.add),
            ),
          ),
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return IndexedStack(
              index: context.read<NavigationBloc>().currentScreen,
              children: const [
                OrganizerHomeScreen(),
                OrganizerProfileScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            context.locale;
            List<String> tabs = ['Home'.tr(), 'Profile'.tr()];
            return Container(
              padding: const EdgeInsets.only(top: 0.3, bottom: 4),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Constants.lightOrange, width: 0.5))),
              child: NavigationBar(
                  selectedIndex: context.read<NavigationBloc>().currentScreen,
                  onDestinationSelected: (value) => context
                      .read<NavigationBloc>()
                      .add(SwitchScreenEvent(targetPage: value)),
                  height: context.getHeight(
                      divideBy:
                          Device.screenType == ScreenType.tablet ? 23 : 16),
                  destinations: List.generate(tabs.length, (index) {
                    return NavigationDestination(
                      label: tabs[index],
                      icon: HugeIcon(
                        size: 24.0,
                        icon: tabsIcons[index],
                        color: context.read<NavigationBloc>().currentScreen ==
                                index
                            ? Constants.mainOrange
                            : Colors.grey,
                      ),
                    );
                  })),
            );
          },
        ),
      ),
    );
  }
}
