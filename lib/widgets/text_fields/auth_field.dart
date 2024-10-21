import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AuthField extends StatelessWidget {
  final String type;
  final TextEditingController? controller;
  final void Function()? onUploadImg;
  const AuthField({super.key, required this.type, this.controller, this.onUploadImg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        type == 'Photo (optional)'
            ? SizedBox(
                width: context.getWidth(),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Photo ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Constants.mainOrange,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "(optional)",
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: "Poppins",
                          color: Constants.mainOrange))
                ])))
            : SizedBox(
                width: context.getWidth(),
                child: Text(type,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Constants.mainOrange,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600))),
        type == 'Photo (optional)'
            ? InkWell(
                onTap: onUploadImg,
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: "Upload photo",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: Color(0xff666666)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                          Radius.circular(20.0)), // Circular border radius
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0), // Reducing height
                  ),
                ),
              )
            : TextFormField(
                controller: controller,
                obscureText: type == 'Password',
                minLines: type == 'Description'
                    ? 3
                    : 1, // Minimum lines for Description
                maxLines: type == 'Description'
                    ? 5
                    : 1, // Max lines for Description, can adjust if needed
                style: const TextStyle(fontSize: 14, fontFamily: "Poppins"),
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      fontSize: 8, fontFamily: "Poppins", color: Colors.red),
                  hintText: type,
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: Color(0xff666666)),
                  filled: true,
                  fillColor: Colors.white70,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.0)), // Circular border radius
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0), // Reducing height
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return "$type is required";
                  }
                  if (type.toLowerCase() == 'email' &&
                      !Constants.emailRegex.hasMatch(text)) {
                    return "Enter a valid email";
                  }
                  if (type.toLowerCase() == 'phone number' &&
                      (text.substring(0, 2) != "05" || text.length != 10)) {
                    return "Enter a valid phone number";
                  }
                  if (type.toLowerCase() == 'password' && text.length < 6) {
                    return "Password is too short";
                  }
                  return null;
                },
              ),
      ],
    );
  }
}
