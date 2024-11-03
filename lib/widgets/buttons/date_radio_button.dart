import 'dart:developer';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class DateRadioButton extends StatelessWidget {
  final List<Workshop> workshop;
  final String selectedDate;
  final void Function(String) onTap;
  const DateRadioButton({super.key, required this.workshop, required this.selectedDate, required this.onTap});
  @override
  Widget build(BuildContext context) {
    log(selectedDate);
    List<String> dates = [];
    for (var element in workshop) {
      DateTime dateTime = DateTime.parse(element.date);
      String formattedDate =
          DateFormat('MMM d', 'en_US').format(dateTime); // format date
      dates.add("$formattedDate ${element.fromTime}-${element.toTime}");
    }
    log(dates.toString());
    return CustomRadioButton(
      buttonTextStyle: const ButtonTextStyle(
        selectedColor: Colors.white,
        unSelectedColor: Constants.mainOrange,
        textStyle: TextStyle(
          fontSize: 11,
        ),
      ),
      elevation: 2,
      autoWidth: false,
      enableButtonWrap: false,
      defaultSelected: dates.where((date)=>date.contains(selectedDate)).toList().first,
      horizontal: false,
      wrapAlignment: WrapAlignment.center,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: dates,
      buttonValues: dates,
      radioButtonValue: onTap,
      selectedColor: Constants.mainOrange,
      enableShape: true,
      selectedBorderColor: Colors.grey, // Set the selected border color to grey
      unSelectedBorderColor:
          Colors.grey, // Set the unselected border color to grey
      width: context.getWidth(divideBy: 2),
    );
  }
}
