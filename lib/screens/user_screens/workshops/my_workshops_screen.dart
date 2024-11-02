import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/other/bloc/booking_bloc.dart';
import 'package:shaghaf/screens/user_screens/other/user_ticket_screen.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';
import 'package:shaghaf/widgets/tapbar/tap_custom.dart';

class MyWorkshopsScreen extends StatelessWidget {
  const MyWorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Workshop> previousWorkshops = [];
    List<Workshop> incomingWorkshops = [];
    for (var booking in GetIt.I.get<DataLayer>().bookings) {
      final workshopId = booking.workshopId;
      for (var workshopGroup in GetIt.I.get<DataLayer>().allWorkshops) {
        for (var workshop in workshopGroup.workshops) {
          if (workshop.workshopId == workshopId &&
              DateTime.now().isAfter(DateTime.parse(workshop.date))) {
            previousWorkshops.add(workshop);
          }
          if (workshop.workshopId == workshopId &&
              DateTime.now().isBefore(DateTime.parse(workshop.date))) {
            incomingWorkshops.add(workshop);
          }
        }
      }
    }
    log(previousWorkshops.length.toString());
    log(incomingWorkshops.length.toString());
    return BlocConsumer<BookingBloc, BookingState>(
      bloc: context.read<BookingBloc>(),
      listener: (context, state) {
        if (state is SuccessState) {
          log('message3');
          for (var booking in GetIt.I.get<DataLayer>().bookings) {
            final workshopId = booking.workshopId;
            for (var workshopGroup in GetIt.I.get<DataLayer>().allWorkshops) {
              for (var workshop in workshopGroup.workshops) {
                if (workshop.workshopId == workshopId &&
                    booking.isAttended == true) {
                  previousWorkshops.add(workshop);
                }
                if (workshop.workshopId == workshopId &&
                    booking.isAttended == false) {
                  incomingWorkshops.add(workshop);
                }
              }
            }
          }
          log(previousWorkshops.length.toString());
          log(incomingWorkshops.length.toString());
        }
      },
      builder: (context, index) => GetIt.I.get<AuthLayer>().user == null
          ? Scaffold(
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: context.getHeight(),
                  child: Center(
                    child: Text("guest bookings".tr(context: context),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            )
          : DefaultTabController(
              length: 2,
              child: Scaffold(
                  backgroundColor: Constants.backgroundColor,
                  appBar: AppBar(
                    forceMaterialTransparency: true,
                    centerTitle: true,
                    title: Text(
                      "guest bookings".tr(context: context),
                      style: const TextStyle(
                          fontSize: 20, color: Constants.textColor),
                    ),
                    bottom: PreferredSize(
                        preferredSize: const Size(double.infinity, 60),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const Divider(),
                              const SizedBox(height: 10),
                              TabBar(
                                overlayColor: const WidgetStatePropertyAll(
                                    Colors.transparent),
                                labelColor: Constants.backgroundColor,
                                splashBorderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                indicator: BoxDecoration(
                                  color:
                                      const Color.fromARGB(165, 222, 101, 49),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                indicatorPadding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                tabs: [
                                  TapCustomStyle(
                                      title: "Incoming".tr(context: context)),
                                  TapCustomStyle(
                                      title: "Previous".tr(context: context))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  body: TabBarView(children: [
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: incomingWorkshops.isNotEmpty
                            ? ListView.separated(
                                itemCount: incomingWorkshops.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 20),
                                itemBuilder: (context, index) => WorkshopCard(
                                  price: incomingWorkshops[index].price,
                                  shape: 'rect',
                                  workshop: GetIt.I
                                      .get<DataLayer>()
                                      .allWorkshops
                                      .firstWhere((workshopGroup) =>
                                          workshopGroup.workshopGroupId ==
                                          incomingWorkshops[index]
                                              .workshopGroupId),
                                  date: incomingWorkshops[index].date,
                                  onTap: () => context.push(
                                      screen: UserTicketScreen(
                                          workshop: incomingWorkshops[index],
                                          booking: GetIt.I
                                              .get<DataLayer>()
                                              .bookings[index],
                                          onBack: () => context.pop())),
                                ),
                              )
                            : SizedBox(
                                height: context.getHeight(),
                                child: Center(child: Text("No booked".tr())))),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: previousWorkshops.isNotEmpty
                            ? ListView.separated(
                                itemCount: previousWorkshops.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 20),
                                itemBuilder: (context, index) => WorkshopCard(
                                  workshop: GetIt.I
                                      .get<DataLayer>()
                                      .allWorkshops
                                      .firstWhere((workshopGroup) =>
                                          workshopGroup.workshopGroupId ==
                                          previousWorkshops[index]
                                              .workshopGroupId),
                                  date: previousWorkshops[index].date,
                                  price: previousWorkshops[index].price,
                                  isAttended: true,
                                  shape: 'rect',
                                  onTap: () => context.push(
                                      screen: UserTicketScreen(
                                          workshop: previousWorkshops[index],
                                          booking: GetIt.I
                                              .get<DataLayer>()
                                              .bookings[index],
                                          onBack: () => context.pop())),
                                ),
                              )
                            : SizedBox(
                                height: context.getHeight(),
                                child: Center(child: Text("No booked".tr())))),
                  ])),
            ),
    );
  }
}
