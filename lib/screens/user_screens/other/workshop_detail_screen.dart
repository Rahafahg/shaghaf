import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moyasar/moyasar.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/widgets/buttons/date_radio_button.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final WorkshopGroupModel workshop;
  const WorkshopDetailScreen({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    final category = GetIt.I
        .get<DataLayer>()
        .categories
        .firstWhere((category) => category.categoryId == workshop.categoryId);
    int quantity = 2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  workshop.image,
                  width: context.getWidth(),
                  height: context.getHeight(divideBy: 3),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40.0,
                  left: 16.0,
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Constants.lightGreen,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workshop.title,
                        style: const TextStyle(
                            color: Constants.textColor,
                            fontSize: 20,
                            fontFamily: "Poppins"),
                      ),
                      Row(
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedUserGroup,
                            color: Constants.textColor,
                          ),
                          const SizedBox(width: 5),
                          Text(workshop.targetedAudience)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(category.icon),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            category.categoryName,
                            style: const TextStyle(
                                color: Constants.textColor,
                                fontSize: 16,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                "assets/images/Organizer_image.jpg",
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Organizer"),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Constants.dividerColor,
                    thickness: 1,
                  ),
                  const Text(
                    "Description",
                  ),
                  const SizedBox(height: 5),
                  Text(
                    workshop.description,
                    style: const TextStyle(
                        color: Constants.lightTextColor, fontSize: 14),
                  ),
                  const Divider(
                    color: Constants.dividerColor,
                    thickness: 1,
                  ),
                  const Text(
                    "Instructor",
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            workshop.workshops.last.instructorImage,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        workshop.workshops.last.instructorName,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    workshop.workshops.last.instructorDescription,
                    style: const TextStyle(
                        color: Constants.lightTextColor, fontSize: 14),
                  ),
                  const Divider(
                    color: Constants.dividerColor,
                    thickness: 1,
                  ),
                  const Text(
                    "Available Days",
                  ),
                  const SizedBox(height: 10),
                  DateRadioButton(workshop: workshop.workshops),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Available Seats",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const HugeIcon(
                          icon: HugeIcons.strokeRoundedSeatSelector,
                          color: Constants.mainOrange),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          "${workshop.workshops.last.availableSeats - 10}/${workshop.workshops.last.availableSeats}"),
                    ],
                  ),
                  const Divider(
                    color: Constants.dividerColor,
                    thickness: 1,
                  ),
                  const Text(
                    "Location",
                  ),
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedLocation01,
                        color: Constants.mainOrange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              workshop.workshops.last.venueName ?? "Online"),
                          subtitle: Text(
                            workshop.workshops.last.venueType ?? "online",
                            style: const TextStyle(
                                color: Constants.lightTextColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(child: Image.asset("assets/images/map_defult.png")),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const HugeIcon(
                                  icon: HugeIcons.strokeRoundedPlusSignSquare,
                                  color: Constants.mainOrange)),
                          Text("$quantity"),
                          IconButton(
                              onPressed: () {},
                              icon: const HugeIcon(
                                  icon: HugeIcons.strokeRoundedMinusSignSquare,
                                  color: Constants.mainOrange))
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(24),
                                width: context.getWidth(),
                                height: context.getHeight(divideBy: 1.35),
                                decoration: const BoxDecoration(
                                  color: Constants.backgroundColor,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    const Text("Fill Card Info",
                                        style: TextStyle(fontSize: 20)),
                                    Theme(
                                      data: ThemeData(
                                          textTheme: const TextTheme()),
                                      child: CreditCard(
                                        config: PaymentConfig(
                                          creditCard: CreditCardConfig(
                                              saveCard: false, manual: false),
                                          publishableApiKey:
                                              dotenv.env['MOYASAR_KEY']!,
                                          amount: ((10 * 100)).toInt(),
                                          description: "description",
                                        ),
                                        onPaymentResult:
                                            (PaymentResponse result) async {
                                          if (result.status ==
                                              PaymentStatus.paid) {
                                            log("Payment is donnee ${result.status}");
                                          } else {}
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.mainOrange,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          "Pay ${workshop.workshops.last.price * quantity} SR",
                          style:
                              const TextStyle(color: Constants.backgroundColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
