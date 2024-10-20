import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/user_screens/user_notification_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: PreferredSize(
        preferredSize:
            Size(context.getWidth(), context.getHeight(divideBy: 13)),
        child: AppBar(
          backgroundColor: Constants.backgroundColor,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello Najwa",
                            style: TextStyle(
                                fontSize: 16, color: Constants.lightOrange)),
                        Text(
                          "Welcome to Shaghaf",
                          style: TextStyle(
                              fontSize: 16, color: Constants.mainOrange),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () =>
                      context.push(screen: const UserNotificationScreen()),
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification01,
                    color: Constants.lightGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Constants.lightGreen,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 12),
                  child: Text(
                    "Workshop of the week",
                    style: TextStyle(fontSize: 18, color: Constants.textColor),
                  ),
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/pasta_workshop.png",
                  fit: BoxFit.cover,
                  // width: context.getWidth(),
                  height: 200,
                ),
                const Center(
                  child: Text(
                    "Pasta Workshop",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  right: 18,
                  child: Row(
                    children: [
                      Text(
                        "4.6",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Text("welcome home")
          ]),
        ),
      ),
    );
  }
}
