import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AddDateField extends StatelessWidget {
  const AddDateField({
    super.key,
    required this.date,
    this.bloc,
  });
  final String date;
  final dynamic bloc;
  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController =
        TextEditingController(text: date.toString());
    return Column(
      children: [
        SizedBox(
            width: context.getWidth(),
            child: const Text("Date",
                style: TextStyle(
                  fontSize: 16,
                  color: Constants.textColor,
                  fontFamily: "Poppins",
                ))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(13.0)), // Circular border radius
              border: Border.all(color: Constants.mainOrange)),
          child: TextField(
            controller: dateController,
            onTap: () async {
              await showDatePicker(
                      initialDate: DateTime.parse(DateTime.now().toString()),
                      context: context,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2025))
                  .then((value) {
                if (value != null) {
                  dateController.text = value.toString().split(' ').first;
                  // bloc.dates.add(dateController.text);
                }
              });
            },
            readOnly: true,
            decoration: const InputDecoration(
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                      Radius.circular(13.0)), // Circular border radius
                ),
                hintText: 'Select Date',
                hintStyle: TextStyle(
                    fontSize: 13,
                    fontFamily: "Poppins",
                    color: Constants.appGreyColor),
                prefixIcon: HugeIcon(
                    icon: HugeIcons.strokeRoundedCalendar03,
                    color: Constants.mainOrange),
                filled: true),
          ),
        ),
      ],
    );
  }
}
