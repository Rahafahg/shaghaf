import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/screens/navigation_screen/navigation_screen.dart';

class UserTicketScreen extends StatelessWidget {
  final BookingModel booking;
  const UserTicketScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text(
            "Ticket",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                color: Constants.textColor),
          ),
          leading: IconButton(
            onPressed: () {
              context.pushRemove(screen: const NavigationScreen());
            },
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
              child: Container(
                decoration: BoxDecoration(
                    color: Constants.ticketCardColor,
                    borderRadius: BorderRadius.circular(20)),
                height: context.getHeight(divideBy: 1.5),
                width: context.getWidth(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pottery making",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          height: context.getHeight(divideBy: 4),
                          width: context.getWidth(divideBy: 1.9),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: QrImageView(
                              data: booking.qrCode,
                              version: QrVersions.auto,
                              size: 250,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Constants.mainOrange),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("${booking.bookingDate}")
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.watch_later_outlined,
                              size: 16, color: Constants.mainOrange),
                          SizedBox(
                            width: 5,
                          ),
                          Text("2-pm to 3-pm")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                      ),
                      const Text(
                        "here is a description of the ticket",
                        style: TextStyle(color: Constants.lightTextColor),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
