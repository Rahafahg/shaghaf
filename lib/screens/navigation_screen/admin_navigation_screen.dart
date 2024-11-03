import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/admin_screens/admin_org_screen.dart';
import 'package:shaghaf/screens/admin_screens/admin_category_screen.dart';
import 'package:shaghaf/screens/admin_screens/bloc/admin_bloc.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/navigation_screen/bloc/navigation_bloc.dart';

class AdminNavigationScreen extends StatelessWidget {
  const AdminNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> tabsIcons = [
      // HugeIcons.strokeRoundedUser,
      HugeIcons.strokeRoundedMenuSquare,
      HugeIcons.strokeRoundedManager,
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => AdminBloc()..add(GetAdminDataEvent())),
        //other blocs can be added here
      ],
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){GetIt.I.get<AuthLayer>().box.remove('admin');context.pushRemove(screen: const LoginScreen());}, icon: const Icon(HugeIcons.strokeRoundedLogout01)),
          actions: [IconButton(onPressed: ()=> context.setLocale(Locale(context.locale == const Locale("en") ? "ar" : "en")), icon: const Icon(Icons.translate))],
          backgroundColor: Constants.backgroundColor,
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Image.asset(
            'assets/images/logo.png',
            height: 60,
            alignment: Alignment.centerLeft, // Align logo to the left
          ),),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return IndexedStack(
              index: context.read<NavigationBloc>().currentScreen,
              children: const [
                AdminCategoryScreen(),
                AdminOrgScreen(),
                // AdminUserScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            context.locale;
            List<String> tabs = ['Categories'.tr(context: context), 'Organizers'.tr(context: context)];
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
