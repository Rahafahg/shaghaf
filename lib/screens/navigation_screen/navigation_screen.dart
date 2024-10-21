import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';
import 'package:shaghaf/screens/user_screens/home/bloc/user_home_bloc.dart';
import 'package:shaghaf/screens/user_screens/home/user_home_screen.dart';
import 'package:shaghaf/screens/user_screens/profile_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserHomeBloc()..add(GetWorkshopsEvent()),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        // other blocs can be added here
      ],
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return IndexedStack(
              index: context.read<NavigationBloc>().currentScreen,
              children: [
                UserHomeScreen(),
                Placeholder(),
                Placeholder(),
                ProfileScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Container(
              color: Constants.lightOrange,
              padding: const EdgeInsets.only(top: 0.3),
              child: NavigationBar(
                selectedIndex: context.read<NavigationBloc>().currentScreen,
                onDestinationSelected: (value) => context
                    .read<NavigationBloc>()
                    .add(SwitchScreenEvent(targetPage: value)),
                height: context.getHeight(divideBy: 15),
                destinations: [
                  NavigationDestination(
                    label: "Home",
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedHome09,
                      color: context.read<NavigationBloc>().currentScreen == 0
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                  NavigationDestination(
                    label: "Categories",
                    icon: HugeIcon(
                      size: 25.0,
                      icon: HugeIcons.strokeRoundedMenuSquare,
                      color: context.read<NavigationBloc>().currentScreen == 1
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                  NavigationDestination(
                    label: "My workshops",
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedFile02,
                      color: context.read<NavigationBloc>().currentScreen == 2
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                  NavigationDestination(
                    label: "Profile",
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedUser,
                      color: context.read<NavigationBloc>().currentScreen == 3
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
