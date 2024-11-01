import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/other/bloc/booking_bloc.dart';

Future<dynamic> moyasar(
      BuildContext context, Workshop specific, BookingBloc bloc, WorkshopGroupModel workshop) {
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
              Text("Card Info".tr(), style: const TextStyle(fontSize: 20)),
              Theme(
                data: ThemeData(textTheme: const TextTheme()),
                child: CreditCard(
                  config: PaymentConfig(
                    creditCard:
                        CreditCardConfig(saveCard: false, manual: false),
                    publishableApiKey: dotenv.env['MOYASAR_KEY']!,
                    amount: ((specific.price * bloc.quantity * 100)).toInt(),
                    description: "description",
                  ),
                  onPaymentResult: (PaymentResponse result) async {
                    if (result.status == PaymentStatus.paid) {
                      bloc.add(SaveBookingEvent(
                          group: workshop,
                          workshop:
                              bloc.chosenWorkshop ?? workshop.workshops.first,
                          quantity: bloc.quantity));
                    } else {}
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

