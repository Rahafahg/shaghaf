import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaghaf/constants/constants.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  String? Function(String?)? validator;
   AuthField(
      {super.key, required this.hint, required this.controller,  this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Text(
              hint,
              style: const TextStyle(color: Constants.mainOrange),
            ),
          ],
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xff666666)),
            filled: true,
            fillColor: const Color.fromARGB(193, 255, 255, 255),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                  Radius.circular(30.0)), // Circular border radius
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 16.0), // Reducing height
          ),
          validator:  (text){
              if(text!.isEmpty) {
                return "$hint field is required";
              }
              if(hint.toLowerCase()=='email' && !Constants.emailRegex.hasMatch(text)) {
                return "Enter a Valid email";
              }
              if(hint.toLowerCase()=='phone number' && (text.substring(0,2)!="05" || text.length!=10)) {
                return "Enter a valid phone number";
              }
              return null;
            },
        ),
      ],
    );
  }
}
