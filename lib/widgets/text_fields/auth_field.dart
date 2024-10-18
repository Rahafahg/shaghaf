import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AuthField extends StatelessWidget {
  final String type;
  final TextEditingController controller;
  const AuthField({super.key, required this.type, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: context.getWidth(),child: Text(type,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.mainOrange))),
        TextFormField(
          obscureText: type=='Password',
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 8),
            hintText: type,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xff666666)),
            filled: true,
            fillColor: Colors.white70,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0)), // Circular border radius
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reducing height
          ),
          validator: (text){
            if(text!.isEmpty) {
              return "$type is required";
            }
            if(type.toLowerCase()=='email' && !Constants.emailRegex.hasMatch(text)) {
              return "Enter a valid email";
            }
            if(type.toLowerCase()=='phone number' && (text.substring(0,2)!="05" || text.length!=10)) {
              return "Enter a valid phone number";
            }
            return null;
          },
        ),
      ],
    );
  }
}