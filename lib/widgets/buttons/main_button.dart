import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class MainButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  const MainButton({super.key, this.onPressed, required this.text, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Constants.mainOrange)),
        child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w600))
      ),
    );
  }
}