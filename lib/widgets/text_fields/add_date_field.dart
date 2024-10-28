import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AddDateField extends StatelessWidget {
  final String date;
  final TextEditingController controller;
  const AddDateField({super.key,required this.date, required this.controller});
  @override
  Widget build(BuildContext context) {
    controller.text = date;
    return Column(
      children: [
        SizedBox(
          width: context.getWidth(),
          child: const Text(
            "Date",
            style: TextStyle(fontSize: 16,color: Constants.textColor,fontFamily: "Poppins")
          )
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Constants.mainOrange),
            borderRadius: const BorderRadius.all(Radius.circular(13.0)), // Circular border radius
          ),
          child: TextField(
            readOnly: true,
            controller: controller,
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.parse(controller.text.toString().isEmpty ? DateTime.now().toString() : controller.text.toString()),
                firstDate: DateTime(2024),
                lastDate: DateTime(2026)
              ).then((value) {
                if (value != null) {
                  controller.text = value.toString().split(' ').first;
                  log(controller.text);
                }
              });
            },
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(13.0)), // Circular border radius
              ),
              hintText: 'Select Date',
              hintStyle: TextStyle(fontSize: 13,fontFamily: "Poppins",color: Constants.appGreyColor),
              prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar03,color: Constants.mainOrange),
            ),
          ),
        ),
      ],
    );
  }
}