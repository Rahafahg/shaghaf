import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/widgets/buttons/date_radio_button.dart';

class WorkshopDetailScreen extends StatelessWidget {
  const WorkshopDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/pasta_workshop.png",
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
                      color: Colors.white,
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
                      const Text("Pasta Workshop Making"),
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedUserGroup,
                            color: Constants.textColor,
                          ),
                          const SizedBox(width: 5),
                          const Text("All")
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Constants.categoryColor_2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            Image.asset("assets/images/cooking-category.png"),
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
                  const Text(
                    "Here will be a description of the workshop",
                    style: TextStyle(
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
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            "assets/images/Instructor_photo.png",
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Mr. Khaled Hassan",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Here is a description of the instructor",
                    style: TextStyle(
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
                  DateRadioButton(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Available Seats",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      HugeIcon(
                          icon: HugeIcons.strokeRoundedSeatSelector,
                          color: Constants.mainOrange),
                      SizedBox(
                        width: 10,
                      ),
                      Text("4/10"),
                    ],
                  ),
                  const Divider(
                    color: Constants.dividerColor,
                    thickness: 1,
                  ),
                  Text(
                    "Location",
                  ),
                  Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedLocation01,
                        color: Constants.mainOrange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text("Location Name"),
                          subtitle: Text(
                            "Venu Type",
                            style: TextStyle(
                                color: Constants.lightTextColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(child: Image.asset("assets/images/map_defult.png")),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedPlusSignSquare,
                                  color: Constants.mainOrange)),
                          Text("1"),
                          IconButton(
                              onPressed: () {},
                              icon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedMinusSignSquare,
                                  color: Constants.mainOrange))
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Your button action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.mainOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          "Pay 50.0 SR",
                          style: TextStyle(color: Constants.backgroundColor),
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
