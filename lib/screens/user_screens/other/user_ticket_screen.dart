import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/navigation_screen/navigation_screen.dart';
import 'package:shaghaf/widgets/cards/ticket_card.dart';

class UserTicketScreen extends StatelessWidget {
  final BookingModel booking;
  final Workshop workshop;
  final Function()? onBack;
  const UserTicketScreen(
      {super.key, required this.booking, this.onBack, required this.workshop});

  @override
  Widget build(BuildContext context) {
    final workshopGroup = GetIt.I.get<DataLayer>().allWorkshops.firstWhere(
        (workshopGroup) =>
            workshopGroup.workshopGroupId == workshop.workshopGroupId);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text(
            "Ticket".tr(),
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          leading: IconButton(
            onPressed: onBack ??
                () => context.pushRemove(screen: const NavigationScreen()),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey.shade500,
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Divider(height: 1),
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: TicketCard(
                  workshopGroup: workshopGroup,
                  booking: booking,
                  workshop: workshop))
        ],
      ),
    );
  }
}
