import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class AddField extends StatelessWidget {
  final String type;
  final TextEditingController? controller;
  final void Function()? onUploadImg;
  final File? image;
  final Function(String?)? onSaved;
  const AddField(
      {super.key,
      required this.type,
      this.controller,
      this.onUploadImg,
      this.image,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
              width: type == "Price in SR".tr(context: context) ||
                      type == 'Seats'.tr(context: context)
                  ? context.getWidth(divideBy: 3)
                  : context.getWidth(),
              child: Text(type,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ))),
          const SizedBox(height: 8),
          type == 'Add Photo'.tr(context: context) ||
                  type == 'Instructor photo'.tr(context: context)
              ? InkWell(
                  onTap: onUploadImg,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.mainOrange),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(13.0)), // Circular border radius
                    ),
                    child: Stack(children: [
                      TextFormField(
                        readOnly: true,
                        maxLines: 5,
                        minLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(
                                13.0)), // Circular border radius
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0), // Reducing height
                        ),
                      ),
                      Positioned(
                          top: 10,
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: image == null
                              ? const HugeIcon(
                                  size: 40,
                                  icon: HugeIcons.strokeRoundedImageAdd01,
                                  color: Constants.mainOrange)
                              : Image.file(image!))
                    ]),
                  ),
                )
              : SizedBox(
                  width: type == "Price in SR".tr(context: context) ||
                          type == "Seats".tr(context: context)
                      ? context.getWidth(divideBy: 3)
                      : context.getWidth(),
                  // decoration: BoxDecoration(
                  // borderRadius: const BorderRadius.all(Radius.circular(13.0)), // Circular border radius
                  // border: Border.all(color: Constants.mainOrange)),
                  child: TextFormField(
                    validator: (text) {
                      String msg = "is required".tr(context: context);
                      if (text!.isEmpty) {
                        return "$type $msg";
                      }
                      if (type == "Meeting Link".tr(context: context)) {
                        RegExp reg = RegExp(
                            r"https:\/\/[\w-]+\.zoom\.us\/(j|my)\/[\w\d]+(\?pwd=[A-Za-z0-9._-]+)?");
                        bool valid = reg.hasMatch(text);
                        if (!valid) {
                          return "Only zoom meetings are accepted";
                        }
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    // onFieldSubmitted: onSaved, // not used ??
                    onChanged: (s) => log(controller?.text ?? 'kk'),
                    controller: controller,
                    obscureText: type == 'Password'.tr(context: context),
                    minLines: type == "Workshop Des".tr(context: context) ||
                            type == "Instructor des".tr(context: context)
                        ? 3
                        : 1, // Minimum lines for Description
                    maxLines: type == "Workshop Des".tr(context: context) ||
                            type == "Instructor des".tr(context: context)
                        ? 5
                        : 1, // Max lines for Description, can adjust if needed
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    keyboardType:
                        type.toLowerCase() == 'email'.tr(context: context)
                            ? TextInputType.emailAddress
                            : type == "Price in SR".tr(context: context) ||
                                    type == 'Seats'.tr(context: context)
                                ? TextInputType.number
                                : null,
                    decoration: InputDecoration(
                      hoverColor: Constants.mainOrange,
                      errorStyle:
                          const TextStyle(fontSize: 8, color: Colors.red),
                      hintText: type == 'Venue type'.tr(context: context)
                          ? "(ex.. Cafe)"
                          : type,
                      hintStyle: const TextStyle(
                          fontSize: 13, color: Constants.appGreyColor),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 14.0), // Reducing height
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.mainOrange),
                          borderRadius:
                              BorderRadius.all(Radius.circular(13.0))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.mainOrange),
                          borderRadius:
                              BorderRadius.all(Radius.circular(13.0))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.mainOrange),
                          borderRadius:
                              BorderRadius.all(Radius.circular(13.0))),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.mainOrange),
                          borderRadius:
                              BorderRadius.all(Radius.circular(13.0))),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
