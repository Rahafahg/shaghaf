import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/add_workshop_screen.dart';
import 'package:shaghaf/screens/organizer_screens/home/organizer_add_workshop_screen.dart';
import 'package:shaghaf/screens/organizer_screens/home/organizer_home_screen.dart';
import 'package:shaghaf/screens/user_screens/profile/bloc/profile_bloc.dart';
import 'package:shaghaf/screens/user_screens/profile/profile_screen.dart';

class OrgNavigationScreen extends StatelessWidget {
  const OrgNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => UserHomeBloc().,
        // ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => UserProfileBloc(),
        ),
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
              onPressed: () => context.push(screen: AddWorkshopScreen()),
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
                ProfileScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
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
                height: context.getHeight(divideBy: 16),
                destinations: [
                  NavigationDestination(
                    label: "Home",
                    icon: HugeIcon(
                      size: 24.0,
                      icon: HugeIcons.strokeRoundedHome09,
                      color: context.read<NavigationBloc>().currentScreen == 0
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                  NavigationDestination(
                    label: "Profile",
                    icon: HugeIcon(
                      size: 24.0,
                      icon: HugeIcons.strokeRoundedUser,
                      color: context.read<NavigationBloc>().currentScreen == 1
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
