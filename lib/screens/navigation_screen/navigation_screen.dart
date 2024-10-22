import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';
import 'package:shaghaf/screens/user_screens/home/bloc/user_home_bloc.dart';
import 'package:shaghaf/screens/user_screens/home/user_home_screen.dart';
import 'package:shaghaf/screens/user_screens/workshops/my_workshops_screen.dart';
import 'package:shaghaf/screens/user_screens/profile/profile_screen.dart';
import 'package:shaghaf/screens/user_screens/categories/user_categories_screen.dart';

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
              children: const [
                UserHomeScreen(),
                UserCategoriesScreen(),
                MyWorkshopsScreen(),
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
                    label: "Categories",
                    icon: HugeIcon(
                      size: 24.0,
                      icon: HugeIcons.strokeRoundedMenuSquare,
                      color: context.read<NavigationBloc>().currentScreen == 1
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                  NavigationDestination(
                    label: "Workshops",
                    icon: HugeIcon(
                      size: 24.0,
                      icon: HugeIcons.strokeRoundedFile02,
                      color: context.read<NavigationBloc>().currentScreen == 2
                          ? Constants.mainOrange
                          : Colors.grey,
                    ),
                  ),
                  NavigationDestination(
                    label: "Profile",
                    icon: HugeIcon(
                      size: 24.0,
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
