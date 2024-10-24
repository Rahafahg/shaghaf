import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

void SuccessfullyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Constants.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Optional: round corners
        ),
        child: Container(
          width: context.getWidth(divideBy: 1.3),
          height: context.getHeight(divideBy: 3),
          child: Stack(
            children: [
              Positioned.fill(
                child: Lottie.asset(
                  "assets/lottie/Animation - 1729493268998.json",
                  fit: BoxFit.cover, // Ensure it covers the entire space
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Column(
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Successfully Completed',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                      color: Colors.green.shade400,
                      size: 100,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'The process completed Successfully',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
