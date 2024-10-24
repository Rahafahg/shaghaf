import 'dart:developer';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class DateRadioButton extends StatelessWidget {
  final List<Workshop> workshop;
  final String selectedDate;
  const DateRadioButton({super.key, required this.workshop, required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    log(selectedDate);
    List<String> dates = [];
    for (var element in workshop) {
      DateTime dateTime = DateTime.parse(element.date);
      String formattedDate =
          DateFormat('MMM d').format(dateTime); // format date
      dates.add("$formattedDate ${element.fromTime}-${element.toTime}");
    }

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
      radioButtonValue: (value) {
        log(value);
        log(dates.toString());
      },
      selectedColor: Constants.mainOrange,

      enableShape: true,
      selectedBorderColor: Colors.grey, // Set the selected border color to grey
      unSelectedBorderColor:
          Colors.grey, // Set the unselected border color to grey
      width: 140,
    );
  }
}
