import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AuthField extends StatelessWidget {
  final String type;
  final TextEditingController? controller;
  final void Function()? onUploadImg;
  final File? image;
  const AuthField({super.key,required this.type,this.controller,this.onUploadImg,this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        type == 'photo'.tr()
          ? SizedBox(
              width: context.getWidth(),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Photo ".tr(),
                      style: const TextStyle(fontSize: 18,color: Constants.mainOrange,fontFamily: "Poppins",fontWeight: FontWeight.w600)
                    ),
                    TextSpan(
                      text: "(optional)".tr(),
                      style: const TextStyle(fontSize: 10,fontFamily: "Poppins",color: Constants.mainOrange)
                    )
                  ]
                )
              )
            )
          : SizedBox(
              width: context.getWidth(),
              child: Text(
                type,
                style: const TextStyle(fontSize: 18,color: Constants.mainOrange,fontFamily: "Poppins",fontWeight: FontWeight.w600)
              )
            ),
          type == 'photo'.tr()
            ? GestureDetector(
                onTap: onUploadImg,
                child: Container(
                  width: context.getWidth(),
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white70,
                  ),
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            image!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        )
                      : const Center(
                          child: HugeIcon(
                              size: 40,
                              icon: HugeIcons.strokeRoundedImageAdd01,
                              color: Constants.mainOrange)
                          // Text(
                          //   "Upload photo",
                          //   style: TextStyle(
                          //       fontSize: 14,
                          //       fontFamily: "Poppins",
                          //       color: Color(0xff666666)),
                          // ),
                          ),
                ),
              )
            : TextFormField(
                controller: controller,
                obscureText: type == 'Password'.tr(),
                minLines: type == 'Description'.tr() || type == 'DescriptionR'.tr()
                    ? 3
                    : 1, // Minimum lines for Description
                maxLines: type == 'Description'.tr() || type == 'DescriptionR'.tr()
                    ? 5
                    : 1, // Max lines for Description, can adjust if needed
                style: const TextStyle(fontSize: 14, fontFamily: "Poppins"),
                keyboardType: type.toLowerCase() == 'email'.tr()
                    ? TextInputType.emailAddress
                    : null,
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
                    return "$type ${"is required".tr()}";
                  }
                  if (type.toLowerCase() == 'email'.tr() && !Constants.emailRegex.hasMatch(text)) {
                    return "Enter a valid email".tr();
                  }
                  if (type.toLowerCase() == 'phone number'.tr() && (text.substring(0, 2) != "05" || text.length != 10)) {
                    return "Enter a valid phone number".tr();
                  }
                  if (type.toLowerCase() == 'password'.tr() && text.length < 6) {
                    return "Password is too short".tr();
                  }
                  return null;
                },
              ),
      ],
    );
  }
}
