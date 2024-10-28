import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class TimeField extends StatelessWidget {
  final TextEditingController timeFromController;
  final TextEditingController timeToController;
  const TimeField({super.key,required this.timeFromController,required this.timeToController});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Time",style: TextStyle(fontSize: 16,color: Constants.textColor,fontFamily: "Poppins")),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("From",style: TextStyle(color: Constants.mainOrange),),
                  const SizedBox(width: 5),
                  Container(
                    width: context.getWidth(divideBy: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(13.0)), // Circular border radius
                      border: Border.all(color: Constants.mainOrange)
                    ),
                    child: TextFormField(
                      controller: timeFromController,
                      readOnly: true,
                      onTap: ()=> showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 10, minute: 47),
                      ).then((value) {
                        if (value != null) {
                          timeFromController.text = value.format(context); // Formats as a readable string
                          log(timeFromController.text);
                        }
                      }
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Reducing height
                      border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(13.0))),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("To",style: TextStyle(color: Constants.mainOrange),),
                const SizedBox(width: 5),
                Container(
                  width: context.getWidth(divideBy: 4),
                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(13.0)),border: Border.all(color: Constants.mainOrange)),
                  child: TextFormField(
                    readOnly: true,
                    controller: timeToController,
                    onTap: ()=>showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 10, minute: 47),
                    ).then((value) {
                      if (value != null) {
                        timeToController.text = value.format(context); // Formats as a readable string
                        log(timeToController.text);
                      }
                    }),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(13.0))),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}