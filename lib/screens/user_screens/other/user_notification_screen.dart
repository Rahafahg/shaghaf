import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/widgets/cards/notification_card.dart';

class UserNotificationScreen extends StatelessWidget {
  const UserNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List? notifications;
    if (GetIt.I.get<AuthLayer>().box.hasData('notifications')) {
      notifications = GetIt.I.get<AuthLayer>().box.read('notifications');
    }

    // log(notifications.toString());
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Align content horizontally to the left
          children: [
            const SizedBox(height: 20),
            Text(
              "Notifications".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ), 
            Column(
              children: List.generate(
                notifications?.length ?? 0,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: NotificationCard(
                      title: notifications?[index]["headings"] ?? "",
                      body: notifications?[index]["contents"] ?? " ",
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
