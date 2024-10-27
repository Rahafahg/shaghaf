import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/screens/user_screens/other/workshop_detail_screen.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';
import 'package:shaghaf/widgets/tapbar/tap_custom.dart';

class OrganizerHomeScreen extends StatelessWidget {
  const OrganizerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Image.asset(
            'assets/images/logo.png',
            height: 100,
            alignment: Alignment.centerLeft, // Align logo to the left
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TabBar(
                    labelColor: Constants.backgroundColor,
                    splashBorderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                    indicator: BoxDecoration(
                      color: const Color.fromARGB(165, 222, 101, 49),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 1),
                    tabs: [
                      TapCustomStyle(
                        title: "Incoming",
                      ),
                      TapCustomStyle(
                        title: "Previous",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: GetIt.I.get<DataLayer>().orgWorkshops.length,
                separatorBuilder: (context,index) => SizedBox(height: 20,),
                itemBuilder: (context,index)=>WorkshopCard(
                  workshop: GetIt.I.get<DataLayer>().orgWorkshops[index],
                  shape: 'rect',
                  onTap: ()=>context.push(screen: WorkshopDetailScreen(workshop: GetIt.I.get<DataLayer>().orgWorkshops[index])),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 27),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
