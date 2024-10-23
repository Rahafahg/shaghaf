 import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

Future<dynamic> Mayasor(BuildContext context, double price) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(24),
            width: context.getWidth(),
            height: context.getHeight(divideBy: 1.35),
            decoration: const BoxDecoration(
              color: Constants.backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Text("Fill Card Info", style: TextStyle(fontSize: 20)),
                Theme(
                  data: ThemeData(textTheme: const TextTheme()),
                  child: CreditCard(
                    config: PaymentConfig(
                      creditCard:
                          CreditCardConfig(saveCard: false, manual: false),
                      publishableApiKey: dotenv.env['MOYASAR_KEY']!,
                      amount: ((price * 100)).toInt(),
                      description: "description",
                    ),
                    onPaymentResult: (PaymentResponse result) async {
                      if (result.status == PaymentStatus.paid) {
                        log("Payment is donnee ${result.status}");
                      } else {}
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
