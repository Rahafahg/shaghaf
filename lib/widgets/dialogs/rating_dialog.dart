import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dialogs/successfully_dialog.dart';

Future<dynamic> ratingDialog(
    {required BuildContext context, required WorkshopGroupModel workshop}) {
  double? rating;
  TextEditingController commentController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: context.getHeight(divideBy: 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: context.getHeight(divideBy: 10),
                      width: context.getWidth(),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Positioned(
                      top: 1,
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Image.asset(scale: 2, "assets/images/rating.png"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("RateQ".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              )),
                          // SizedBox(
                          //   width: context.getWidth(divideBy: 3.1),
                          //   child: Text(" ${workshop.title}",
                          //       overflow: TextOverflow.ellipsis,
                          //       maxLines: 1,
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         color: Theme.of(context)
                          //             .textTheme
                          //             .bodyLarge!
                          //             .color,
                          //       )),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      RatingBar(
                        alignment: Alignment.center,
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        onRatingChanged: (value) => rating = value,
                        initialRating: 0,
                        maxRating: 5,
                      ),
                      const SizedBox(height: 16),
                      Text("Rate comment".tr()),
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
                    controller: commentController,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 16),
                MainButton(
                  text: "Submit".tr(),
                  width: context.getWidth(divideBy: 2),
                  onPressed: () {
                    if (rating != null) {
                      GetIt.I.get<SupabaseLayer>().submitRating(
                          workshopGroupId: workshop.workshopGroupId,
                          rating: rating!,
                          comment: commentController.text);
                      context.pop();
                      successfullyDialog(
                          context: context, title: "Rate Thank".tr());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Rate msg".tr())));
                    }
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
}
