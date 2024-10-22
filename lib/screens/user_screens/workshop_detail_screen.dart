import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/widgets/buttons/date_radio_button.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final WorkshopGroupModel workshop;
  const WorkshopDetailScreen({super.key, required this.workshop});

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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pasta Workshop Making"),
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedUserGroup,
                            color: Constants.textColor,
                          ),
                          SizedBox(width: 5),
                          Text("All")
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
            Image.asset('assets/images/categories/Frame 117.png'),
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
                  const Row(
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
                  const Text(
                    "Location",
                  ),
                  const Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedLocation01,
                        color: Constants.mainOrange,
                      ),
                      SizedBox(width: 8),
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
                          const Text("1"),
                          IconButton(
                              onPressed: () {},
                              icon: const HugeIcon(
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
                          shape: const RoundedRectangleBorder(
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
