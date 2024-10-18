import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const AuthTextButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: text.toLowerCase().contains('already') ? context.getWidth() : null,
        child: Text(
          text,
          textAlign: text.toLowerCase().contains('already') ? TextAlign.end : null,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Constants.mainOrange,
            decoration: TextDecoration.underline,
            decorationColor: Constants.mainOrange,
            fontSize: 11
          )
        )
      )
    );
  }
}