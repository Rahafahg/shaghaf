import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';
import 'package:shaghaf/screens/user_screens/categories/bloc/categories_bloc.dart';
import 'package:shaghaf/screens/user_screens/home/bloc/user_home_bloc.dart';
import 'package:shaghaf/screens/user_screens/home/user_home_screen.dart';
import 'package:shaghaf/screens/user_screens/other/bloc/booking_bloc.dart';
import 'package:shaghaf/screens/user_screens/profile/bloc/profile_bloc.dart';
import 'package:shaghaf/screens/user_screens/workshops/my_workshops_screen.dart';
import 'package:shaghaf/screens/user_screens/profile/profile_screen.dart';
import 'package:shaghaf/screens/user_screens/categories/user_categories_screen.dart';
import 'package:sizer/sizer.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> tabsIcons = [
      HugeIcons.strokeRoundedHome09,
      HugeIcons.strokeRoundedMenuSquare,
      HugeIcons.strokeRoundedFile02,
      HugeIcons.strokeRoundedUser
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserHomeBloc()..add(GetWorkshopsEvent()),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => UserProfileBloc(),
        ),
        BlocProvider(
          create: (context) => BookingBloc()..add(GetBookingsEvent()),
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
            context.locale;
            List<String> tabs = [
              "Home".tr(),
              "Categories".tr(),
              "Workshops".tr(),
              "Profile".tr()
            ];
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
                          Device.screenType == ScreenType.tablet ? 20 : 16),
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
