import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String msg;
  const ErrorDialog({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.error_outline_rounded,
        color: Colors.red,
        size: 50
      ),
      content: Text(
        "Error : $msg",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w500
        )
      ),
    );
  }
}