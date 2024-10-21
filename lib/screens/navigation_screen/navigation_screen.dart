import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<NavigationBloc>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              return bloc.screens[bloc.currentScreen];
            },
          ),
          bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              return Container(
                color: Constants.lightOrange,
                padding: const EdgeInsets.only(top: 0.3),
                child: NavigationBar(
                  selectedIndex: bloc.currentScreen,
                  onDestinationSelected: (value) =>
                      bloc.add(SwitchScreenEvent(targetPage: value)),
                  height: context.getHeight(divideBy: 15),
                  destinations: [
                    NavigationDestination(
                        label: "Home",
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedHome09,
                          color: bloc.currentScreen == 0
                              ? Constants.mainOrange
                              : Colors.grey,
                        )),
                    NavigationDestination(
                        label: "Categories",
                        icon: HugeIcon(
                          size: 25.0,
                          icon: HugeIcons.strokeRoundedMenuSquare,
                          color: bloc.currentScreen == 1
                              ? Constants.mainOrange
                              : Colors.grey,
                        )),
                    NavigationDestination(
                      label: "My workshops",
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedFile02,
                        color: bloc.currentScreen == 2
                            ? Constants.mainOrange
                            : Colors.grey,
                      ),
                    ),
                    NavigationDestination(
                      label: "Profile",
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedUser,
                        color: bloc.currentScreen == 3
                            ? Constants.mainOrange
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
