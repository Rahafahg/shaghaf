import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class TimeField extends StatelessWidget {
  final TextEditingController timeFromController;
  final TextEditingController timeToController;
  const TimeField({super.key,required this.timeFromController,required this.timeToController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Time".tr(context: context),style: const TextStyle(fontSize: 16, color: Constants.textColor)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // from
              Row(
                children: [
                  Text("From".tr(context: context),style: const TextStyle(color: Constants.mainOrange)),
                  const SizedBox(width: 5),
                  Container(
                    width: context.getWidth(divideBy: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(13.0)), // Circular border radius
                      border: Border.all(color: Constants.mainOrange)
                    ),
                    child: TextFormField(
                      controller: timeFromController,
                      readOnly: true,
                      onTap: () => showTimePicker(
                        builder: (context, child) => Theme(data: Theme.of(context).copyWith(timePickerTheme: TimePickerThemeData(hourMinuteTextColor: Theme.of(context).brightness==Brightness.dark ? Colors.white : Colors.black)), child: child!),
                        context: context,
                        initialTime: const TimeOfDay(hour: 10, minute: 47),
                      ).then((value) {
                        if (value != null) {
                          timeFromController.text = value.format(context); // Formats as a readable string
                          log(timeFromController.text);
                        }
                      }),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reducing height
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius:BorderRadius.all(Radius.circular(13.0))),
                      ),
                    ),
                  ),
                ],
              ),
              // to
              Row(
                children: [
                  Text("To".tr(context: context),style: const TextStyle(color: Constants.mainOrange)),
                  const SizedBox(width: 5),
                  Container(
                    width: context.getWidth(divideBy: 4),
                    decoration: BoxDecoration(borderRadius:const BorderRadius.all(Radius.circular(13.0)),border: Border.all(color: Constants.mainOrange)),
                    child: TextFormField(
                      readOnly: true,
                      controller: timeToController,
                      onTap: () => showTimePicker(
                        builder: (context, child) => Theme(data: Theme.of(context).copyWith(timePickerTheme: TimePickerThemeData(hourMinuteTextColor: Theme.of(context).brightness==Brightness.dark ? Colors.white : Colors.black)), child: child!),
                        context: context,
                        initialTime: const TimeOfDay(hour: 10, minute: 47),
                      ).then((value) {
                        if (value != null) {
                          timeToController.text = value.format(context); // Formats as a readable string
                          log(timeToController.text);
                        }
                      }),
                      decoration:  InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius:BorderRadius.all(Radius.circular(13.0))),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                ],
              )
            ]
          ),
        ],
      ),
    );
  }
}