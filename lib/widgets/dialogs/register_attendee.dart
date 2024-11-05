import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/cards/ticket_card.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';

import 'dart:async';
import 'dart:developer';

Future<List<Map<String, dynamic>>> registerAttendee({
  required BuildContext context,
  required WorkshopGroupModel workshop,
  required Workshop specific,
}) {
  TextEditingController qrController = TextEditingController();
  Completer<List<Map<String, dynamic>>> completer = Completer();

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Enter Attendee booking id".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Constants.textColor,
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(66, 206, 208, 210),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Constants.dividerColor)),
                  child: TextField(
                    controller: qrController,
                    decoration: const InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16),
                MainButton(
                  text: "Submit".tr(),
                  width: context.getWidth(divideBy: 2),
                  onPressed: () async {
                    context.pop();
                    final List<Map<String, dynamic>> response = await GetIt.I
                        .get<SupabaseLayer>()
                        .supabase
                        .from('booking')
                        .update({'is_attended': true}).match({
                      'workshop_id': specific.workshopId,
                      'qr_code': qrController.text,
                      'is_attended': false,
                    }).select();

                    // Complete the completer with the response
                    completer.complete(response);
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      );
    },
  );

  // Return the future from the completer
  return completer.future;
}
