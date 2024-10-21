import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/widgets/cards/notification_card.dart';

class UserNotificationScreen extends StatelessWidget {
  const UserNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade500,
          ),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 100,
          alignment: Alignment.centerLeft, // Align logo to the left
        ),
      ),
      backgroundColor: Constants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Align content horizontally to the left
          children: [
            const SizedBox(height: 20),
            Text(
              "Notifications",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            const NotificationCard(
              title: "Check the new workshop!",
              body: "data to bee displayed in here for the notification",
            ),
            const SizedBox(
              height: 10,
            ),
            const NotificationCard(
              title: "Another Notificatio",
              body: "this is the body of the notification",
            )
          ],
        ),
      ),
    );
  }
}
