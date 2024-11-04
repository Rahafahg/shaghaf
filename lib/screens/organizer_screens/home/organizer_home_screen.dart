import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      TapCustomStyle(title: "Incoming".tr(context: context)),
                      TapCustomStyle(title: "Previous".tr(context: context))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
            bloc: context.read<AddWorkshopBloc>(),
            builder: (context, state) {
              List<WorkshopGroupModel> incoming = [];
              List<WorkshopGroupModel> previous = [];
              for (var workshopGroup in GetIt.I.get<DataLayer>().orgWorkshops) {
                if (workshopGroup.workshops.any((workshop) =>
                    DateTime.now().isBefore(DateTime.parse(workshop.date)))) {
                  incoming.add(workshopGroup);
                }
                if (workshopGroup.workshops.any((workshop) =>
                    DateTime.now().isAfter(DateTime.parse(workshop.date)))) {
                  previous.add(workshopGroup);
                }
              }
              log(incoming.length.toString());
              log(previous.length.toString());
              return TabBarView(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: incoming.isNotEmpty
                          ? ListView.separated(
                              itemCount: incoming.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 20,
                              ),
                              itemBuilder: (context, index) => WorkshopCard(
                                workshop: incoming[index],
                                shape: 'rect',
                                onTap: () => context.push(
                                    screen: WorkshopDetailScreen(
                                        workshop: incoming[index])),
                              ),
                            )
                          : SizedBox(
                              height: context.getHeight(),
                              child: Center(
                                  child:
                                      Text("No incoming".tr(context: context))),
                            )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: previous.isNotEmpty
                          ? ListView.separated(
                              itemCount: previous.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 20,
                              ),
                              itemBuilder: (context, index) => WorkshopCard(
                                workshop: previous[index],
                                shape: 'rect',
                                onTap: () => context.push(
                                    screen: WorkshopDetailScreen(
                                        workshop: previous[index])),
                              ),
                            )
                          : SizedBox(
                              height: context.getHeight(),
                              child: Center(
                                  child:
                                      Text("No previous".tr(context: context))),
                            )),
                ],
              );
            }),
      ),
    );
  }
}
