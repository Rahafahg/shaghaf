import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class TapCustomStyle extends StatelessWidget {
  final String title;
  const TapCustomStyle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 38,
        width: context.getHeight(divideBy: 4.6),
        decoration: BoxDecoration(
          border: Border.all(color: Constants.mainOrange),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(title));
  }
}
