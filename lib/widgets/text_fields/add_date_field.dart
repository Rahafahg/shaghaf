import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AddDateField extends StatelessWidget {
  final String date;
  final TextEditingController controller;
  const AddDateField({super.key, required this.date, required this.controller});
  @override
  Widget build(BuildContext context) {
    controller.text = date;
    return Column(
      children: [
        SizedBox(
            width: context.getWidth(),
            child: Text("Date".tr(context: context),
                style: const TextStyle(
                  fontSize: 16,
                  color: Constants.textColor,
                ))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Constants.mainOrange),
            borderRadius: const BorderRadius.all(
                Radius.circular(13.0)), // Circular border radius
          ),
          child: TextField(
            readOnly: true,
            controller: controller,
            onTap: () async {
              await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(
                          controller.text.toString().isEmpty
                              ? DateTime.now().toString()
                              : controller.text.toString()),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 0)),
                      lastDate: DateTime(2026))
                  .then((value) {
                if (value != null) {
                  controller.text = value.toString().split(' ').first;
                  log(controller.text);
                }
              });
            },
            decoration: InputDecoration(
              // filled: true,
              // fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                    Radius.circular(13.0)), // Circular border radius
              ),
              hintText: 'Select Date'.tr(context: context),
              hintStyle:
                  const TextStyle(fontSize: 13, color: Constants.appGreyColor),
              prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCalendar03,
                  color: Constants.mainOrange),
            ),
          ),
        ),
      ],
    );
  }
}
