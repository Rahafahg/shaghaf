// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:shaghaf/constants/constants.dart';
// import 'package:shaghaf/extensions/screen_size.dart';
// import 'package:image_picker/image_picker.dart';

// class AuthField extends StatelessWidget {
//   final String type;
//   final TextEditingController? controller;
//   const AuthField({super.key, required this.type, this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         type=='Photo (optional)' ?
//         SizedBox(
//           width: context.getWidth(),
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(text: "Photo ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.mainOrange)),
//                 TextSpan(text: "(optional)", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: Constants.mainOrange))
//               ]
//             )
//           )
//         )
//         : SizedBox(width: context.getWidth(),child: Text(type,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.mainOrange))),
//         type=='Photo (optional)' ?
//         InkWell(
//           onTap: () async {
//             final photoAsFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//             log(photoAsFile.toString());
//             log(photoAsFile.runtimeType.toString());
//             String? photoName = photoAsFile?.path.toString().split('/').last;
//             log(photoName ?? 'no photo');
//           },
//           child: TextFormField(
//             enabled: false,
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white70,
//               hintText: "Upload photo",
//               hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color:  const Color(0xff666666)),
//               border: const OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.all(Radius.circular(20.0)), // Circular border radius
//               ),
//               contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reducing height
//             ),
//           ),
//         )
//         : TextFormField(
//           controller: controller,
//           obscureText: type=='Password',
//           style: Theme.of(context).textTheme.bodySmall,
//           decoration: InputDecoration(
//             errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 8),
//             hintText: type,
//             hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xff666666)),
//             filled: true,
//             fillColor: Colors.white70,
//             border: const OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(20.0)), // Circular border radius
//             ),
//             contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reducing height
//           ),
//           validator: (text){
//             if(text!.isEmpty) {
//               return "$type is required";
//             }
//             if(type.toLowerCase()=='email' && !Constants.emailRegex.hasMatch(text)) {
//               return "Enter a valid email";
//             }
//             if(type.toLowerCase()=='phone number' && (text.substring(0,2)!="05" || text.length!=10)) {
//               return "Enter a valid phone number";
//             }
//             if(type.toLowerCase()=='password' && (text.length < 6)) {
//               return "Password is too short";
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:image_picker/image_picker.dart';

class AuthField extends StatelessWidget {
  final String type;
  final TextEditingController? controller;
  const AuthField({super.key, required this.type, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        type=='Photo (optional)' ?
        SizedBox(
          width: context.getWidth(),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Photo ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.mainOrange)),
                TextSpan(text: "(optional)", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: Constants.mainOrange))
              ]
            )
          )
        )
        : SizedBox(width: context.getWidth(),child: Text(type,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.mainOrange))),
        
        type=='Photo (optional)' ?
        InkWell(
          onTap: () async {
            final photoAsFile = await ImagePicker().pickImage(source: ImageSource.gallery);
            log(photoAsFile.toString());
            log(photoAsFile.runtimeType.toString());
            String? photoName = photoAsFile?.path.toString().split('/').last;
            log(photoName ?? 'no photo');
          },
          child: TextFormField(
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              hintText: "Upload photo",
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color:  const Color(0xff666666)),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0)), // Circular border radius
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reducing height
            ),
          ),
        )
        : TextFormField(
          controller: controller,
          obscureText: type == 'Password',
          minLines: type == 'Description' ? 3 : 1, // Minimum lines for Description
          maxLines: type == 'Description' ? 5 : 1, // Max lines for Description, can adjust if needed
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
          validator: (text) {
            if (text!.isEmpty) {
              return "$type is required";
            }
            if (type.toLowerCase() == 'email' && !Constants.emailRegex.hasMatch(text)) {
              return "Enter a valid email";
            }
            if (type.toLowerCase() == 'phone number' && (text.substring(0, 2) != "05" || text.length != 10)) {
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
