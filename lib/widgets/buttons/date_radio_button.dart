import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class DateRadioButton extends StatelessWidget {
  const DateRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.white,
        unSelectedColor: Constants.mainOrange,
        textStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
      autoWidth: false,
      enableButtonWrap: true,
      wrapAlignment: WrapAlignment.center,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: const [
        "10 Sep",
        "11 Sep",
        "12 Sep",
        "13 Sep",
      ],
      buttonValues: const [
        "10 Sep",
        "11 Sep",
        "12 Sep",
        "13 Sep",
      ],
      radioButtonValue: (value) {
        print(value);
      },
      selectedColor: Constants.mainOrange,

      enableShape: true,
      selectedBorderColor: Colors.grey, // Set the selected border color to grey
      unSelectedBorderColor:
          Colors.grey, // Set the unselected border color to grey
      width: 90,
    );
  }
}
