import 'dart:developer';
import 'dart:io';

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
  const AddField({super.key,required this.type,this.controller,this.onUploadImg,this.image,this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            width: type == 'Price in SR' || type == 'Seats' ? context.getWidth(divideBy: 3) : context.getWidth(),
            child: Text(
              type,
              style: const TextStyle(fontSize: 16,color: Constants.textColor,fontFamily: "Poppins")
            )
          ),
          const SizedBox(height: 8),
          type == 'Add Photo' || type == 'Instructor photo'
          ? InkWell(
            onTap: onUploadImg,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Constants.mainOrange),
                borderRadius: const BorderRadius.all(Radius.circular(13.0)), // Circular border radius
              ),
              child: Stack(
                children: [
                  TextFormField(
                    readOnly: true,
                    maxLines: 5,
                    minLines: 3,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(13.0)), // Circular border radius
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0), // Reducing height
                    ),
                  ),
                  Positioned(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: image == null ? const HugeIcon(size: 40,icon: HugeIcons.strokeRoundedImageAdd01,color: Constants.mainOrange) : Image.file(image!)
                  )
                ]
              ),
            ),
          )
          : Container(
              width: type == 'Price in SR' || type == 'Seats' ? context.getWidth(divideBy: 3) : context.getWidth(),
              // decoration: BoxDecoration(
                // borderRadius: const BorderRadius.all(Radius.circular(13.0)), // Circular border radius
                // border: Border.all(color: Constants.mainOrange)),
                child: TextFormField(
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "$type is required";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  // onFieldSubmitted: onSaved, // not used ??
                  onChanged: (s)=>log(controller?.text ?? 'kk'),
                  controller: controller,
                  obscureText: type == 'Password',
                  minLines: type == 'Workshop Description' || type == 'Instructor description' ? 3 : 1, // Minimum lines for Description
                  maxLines: type == 'Workshop Description' || type == 'Instructor description' ? 5 : 1, // Max lines for Description, can adjust if needed
                  style: const TextStyle(fontSize: 14, fontFamily: "Poppins"),
                  keyboardType: type.toLowerCase() == 'email' ? TextInputType.emailAddress : null,
                  decoration: InputDecoration(
                    hoverColor: Constants.mainOrange,
                    errorStyle: const TextStyle(fontSize: 8,fontFamily: "Poppins",color: Colors.red),
                    hintText: type == 'Venue type' ? "(ex.. Cafe)" : type,
                    hintStyle: const TextStyle(fontSize: 13,fontFamily: "Poppins",color: Constants.appGreyColor),
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0), // Reducing height
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Constants.mainOrange),borderRadius: BorderRadius.all(Radius.circular(13.0))),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Constants.mainOrange),borderRadius: BorderRadius.all(Radius.circular(13.0))),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Constants.mainOrange),borderRadius: BorderRadius.all(Radius.circular(13.0))),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Constants.mainOrange),borderRadius: BorderRadius.all(Radius.circular(13.0))),
                ),
            ),
          )
        ],
      ),
    );
  }
}