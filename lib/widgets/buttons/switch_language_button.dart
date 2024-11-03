
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class switchingLanguage extends StatelessWidget {
  const switchingLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        // onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      color: Color.fromARGB(104, 222, 101, 49),
                      spreadRadius: 0)
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Constants.profileColor,
                child: IconButton(
                  onPressed: () {
                    //context.setLocale(Locale("en"));
                    // Locale currentLocale = context.locale;
                    if (context.locale == const Locale("en")) {
                      context.setLocale(const Locale("ar"));
                      print("tran to ar");
                    } else {
                      context.setLocale(const Locale("en"));
                      print("trans to en");
                    }
                  },
                  icon: const Icon(Icons.translate),
                  color: Constants.mainOrange,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text("Switch".tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Constants.textColor,
                ))
          ],
        ),
      ),
    );
  }
}
