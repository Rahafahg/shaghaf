import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class SwitchingLanguage extends StatelessWidget {
  const SwitchingLanguage({super.key});

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
                      color: Color.fromARGB(104, 174, 76, 34),
                      spreadRadius: 0)
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: IconButton(
                  icon: const Icon(Icons.translate),
                  color: Constants.mainOrange,
                  onPressed: () {
                    if (context.locale == const Locale("en")) {
                      context.setLocale(const Locale("ar"));
                    } else {
                      context.setLocale(const Locale("en"));
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text("Switch".tr(),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color)) // 17 pop ?
          ],
        ),
      ),
    );
  }
}
