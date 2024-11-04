import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.workshopGroup,
    required this.booking,
    required this.workshop,
  });

  final WorkshopGroupModel workshopGroup;
  final BookingModel booking;
  final Workshop workshop;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(20)),
      height: context.getHeight(divideBy: 1.5),
      width: context.getWidth(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(Icons.numbers,
                    size: 16, color: Constants.mainOrange),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Text("Tickets num".tr()),
                    Text(" ${booking.numberOfTickets}")
                  ],
                )
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: Constants.mainOrange),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Text("Booked at".tr()),
                    Text(" ${booking.bookingDate.toString().split(".").first}")
                  ],
                )
              ],
            ),
            const Divider(),
            Text(workshopGroup.title,
                style: const TextStyle(fontSize: 20, fontFamily: "Poppins")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: Constants.mainOrange),
                    const SizedBox(width: 5),
                    Text(workshop.date)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined,
                        size: 16, color: Constants.mainOrange),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        Text("From".tr()),
                        Text(workshop.fromTime),
                        const SizedBox(width: 5),
                        Text("To".tr()),
                        Text(workshop.toTime),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
