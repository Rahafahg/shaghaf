
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class switchingLanguage extends StatelessWidget {
  final Function()? onChangeLang;
  const switchingLanguage({super.key, this.onChangeLang});

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
                  onPressed: onChangeLang,
                  icon: const Icon(Icons.translate),
                  color: Constants.mainOrange,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text("Switch".tr(),
                style: const TextStyle(
                  fontSize: 17,
                  color: Constants.textColor,
                  fontFamily: "Poppins",
                ))
          ],
        ),
      ),
    );
  }
}