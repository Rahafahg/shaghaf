import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.workshopGroup,
    required this.booking,
    required this.workshop,
    this.frombarcode = false,
  });

  final WorkshopGroupModel workshopGroup;
  final BookingModel booking;
  final Workshop workshop;
  final bool? frombarcode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      width: context.getWidth(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.numbers,
                    size: 16, color: Constants.mainOrange),
                const SizedBox(width: 5),
                Text("Tickets num".tr()),
                Text(" ${booking.numberOfTickets}")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: Constants.mainOrange),
                const SizedBox(width: 5),
                Text("Booked at".tr()),
                Text(" ${booking.bookingDate.toString().split(".").first}")
              ],
            ),
            Row(
              children: [
                const Icon(Icons.numbers,
                    size: 16, color: Constants.mainOrange),
                const SizedBox(width: 5),
                Text("Booking number".tr(context: context)),
                const SizedBox(height: 5),
                Text(booking.qrCode, style: const TextStyle(fontSize: 16)),
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: booking.qrCode));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("copied".tr(context: context))));
                    },
                    icon: const Icon(HugeIcons.strokeRoundedCopy01))
              ],
            ),
            const SizedBox(height: 15),
            frombarcode == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SizedBox(height: 15),
                      Text(workshopGroup.title,
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      Column(
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
                                  const SizedBox(width: 5),
                                  Text(workshop.fromTime),
                                  const SizedBox(width: 10),
                                  Text("To".tr()),
                                  const SizedBox(width: 5),
                                  Text(workshop.toTime),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      workshop.isOnline == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Icon(
                                      HugeIcons.strokeRoundedVideo02,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text("Meeting Url".tr(context: context),
                                        style: const TextStyle(fontSize: 16)),
                                    IconButton(
                                        onPressed: () async {
                                          if (workshop.meetingUrl != null) {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text:
                                                        workshop.meetingUrl!));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text("copied".tr(
                                                        context: context))));
                                          }
                                        },
                                        icon: const Icon(
                                            HugeIcons.strokeRoundedCopy01))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () async {
                                    if (workshop.meetingUrl != null) {
                                      final Uri url =
                                          Uri.parse(workshop.meetingUrl!);
                                      if (!await launchUrl(url)) {
                                        throw Exception(
                                            'Could not launch $url');
                                      }
                                    }
                                  },
                                  child: Text(workshop.meetingUrl ?? "",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Constants.lightOrange)),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
