import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/user_screens/user_ticket_screen.dart';

class MyWorkShopsCard extends StatelessWidget {
  const MyWorkShopsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(screen: UserTicketScreen());
      },
      child: Container(
        alignment: Alignment.center,
        width: context.getWidth(divideBy: 1.1),
        height: context.getHeight(divideBy: 6.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Constants.cardColor,
          border: Border.all(color: Constants.appGreyColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Align(
                  widthFactor: 0.45,
                  child: Image.asset(
                    "assets/images/pasta_workshop.png",
                  ),
                )),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.getWidth(divideBy: 1.85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.getWidth(divideBy: 2.5),
                        child: const Text(
                          "Make your own pasta",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text("4.2",
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Cooking",
                  style: TextStyle(fontSize: 14, color: Constants.mainOrange),
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        child: Image.asset(
                            "assets/images/default_organizer_image.png")),
                    const SizedBox(width: 4),
                    Text(
                      "Mr. Khaled Hassan",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  width: context.getWidth(divideBy: 1.85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            "Jan 30-Feb 2, 2024",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(HugeIcons.strokeRoundedUser,
                              size: 16, color: Constants.lightGreen),
                          const SizedBox(width: 4),
                          Text("50 SR",
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
