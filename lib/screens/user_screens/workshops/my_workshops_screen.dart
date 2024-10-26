import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/other/user_ticket_screen.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';
import 'package:shaghaf/widgets/tapbar/tap_custom.dart';

class MyWorkshopsScreen extends StatelessWidget {
  const MyWorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<BookingModel> bookings = GetIt.I.get<DataLayer>().bookings;
    log('message1');
    log(bookings.length.toString());
    List<WorkshopGroupModel> workshops = GetIt.I.get<DataLayer>().workshops;
    log('message2');
    log(workshops.length.toString());
    List<Workshop> bookedWorkshops = getBookedWorkshops();
    log('message3');
    log(bookedWorkshops.length.toString());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text(
            "My Workshops",
            style: TextStyle(fontSize: 20,fontFamily: "Poppins",color: Constants.textColor),
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
                      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                      labelColor: Constants.backgroundColor,
                      splashBorderRadius: const BorderRadius.all(Radius.circular(10)),
                      indicator: BoxDecoration(
                        color: const Color.fromARGB(165, 222, 101, 49),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 1),
                      tabs: const [TapCustomStyle(title: "Incoming"),TapCustomStyle(title: "Previous")],
                    ),
                  ],
                ),
              )
            ),
          ),
          body: TabBarView(
            children: [
              
              Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                  itemCount: bookedWorkshops.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 20,),
                  itemBuilder: (context, index) => WorkshopCard(
                    workshop: workshops.firstWhere((workshopGroup)=>workshopGroup.workshopGroupId==bookedWorkshops[index].workshopGroupId),
                    date: bookedWorkshops[index].date,
                    onTap: ()=>context.push(screen: UserTicketScreen(workshop: bookedWorkshops[index],booking: bookings[index], onBack: ()=>context.pop())),
                    price: bookedWorkshops[index].price,
                    shape: 'rect',
                  ),
                ),
              ),
            // Text(GetIt.I.get<DataLayer>().bookings.length.toString()),
            Text(bookings.length.toString()),
          ])),
    );
  }
}
