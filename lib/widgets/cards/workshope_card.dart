import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/widgets/dialogs/rating_dialog.dart';
import 'package:shaghaf/widgets/effects/shimmer.dart';

class WorkshopCard extends StatelessWidget {
  final WorkshopGroupModel workshop;
  final String shape;
  final Function()? onTap;
  final String? date;
  final double? price;
  final bool? isAttended;
  const WorkshopCard({
    super.key,
    required this.workshop,
    this.shape = 'square',
    this.onTap,
    this.date,
    this.price,
    this.isAttended,
  });

  @override
  Widget build(BuildContext context) {
    var fraction = (workshop.rating % 1 * pow(10, 2)).floor();
    String rating = "${workshop.rating.toString().split(".")[0]}.$fraction";
    return InkWell(
        onTap: onTap,
        child: shape == 'square'
            ? Container(
                width: context.getWidth(divideBy: 2.3),
                height: context.getHeight(divideBy: 2),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 2,
                          offset: const Offset(2, 1))
                    ]),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: SizedBox(
                            height: 100,
                            width: context.getWidth(divideBy: 2.3),
                            child: Image.network(workshop.image,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    loadingProgress == null
                                        ? child
                                        : const ShimmerEffect()))),
                    Positioned(
                      top: 90,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Theme.of(context).colorScheme.surface),
                        width: context.getWidth(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workshop.title,
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                GetIt.I
                                    .get<DataLayer>()
                                    .categories
                                    .firstWhere((category) =>
                                        category.categoryId ==
                                        workshop.categoryId)
                                    .categoryName,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 16,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    workshop.workshops.isEmpty
                                        ? 'handle me later'
                                        : workshop.workshops.first.date,
                                    style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 8,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.orange),
                                  const SizedBox(width: 4),
                                  Text(rating,
                                      style: const TextStyle(
                                          fontFamily: "Poppins", fontSize: 8)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: context.getWidth(divideBy: 1.1),
                height: context.getHeight(divideBy: 6.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(color: Constants.appGreyColor),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 3,
                        offset: const Offset(2, 2))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: SizedBox(
                          width: context.getWidth(divideBy: 3.5),
                          child: SizedBox(
                              width: context.getWidth(),
                              height: context.getHeight(),
                              child: Image.network(workshop.image,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          loadingProgress == null
                                              ? child
                                              : const ShimmerEffect())),
                        )),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: context.getWidth(divideBy: 1.85),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: context.getWidth(divideBy: 2.5),
                                child: Text(
                                  workshop.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.orange),
                                  const SizedBox(width: 4),
                                  Text(rating,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          GetIt.I
                              .get<DataLayer>()
                              .categories
                              .firstWhere((category) =>
                                  category.categoryId == workshop.categoryId)
                              .categoryName,
                          style: const TextStyle(
                              fontSize: 14, color: Constants.mainOrange),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 12,
                                backgroundImage: Image.network(
                                        fit: BoxFit.cover,
                                        workshop.workshops.first.instructorImage,
                                        loadingBuilder: (context, child,
                                                loadingProgress) =>
                                            loadingProgress == null
                                                ? child
                                                : Image.asset(
                                                    "assets/images/default_organizer_image.png"))
                                    .image),
                            const SizedBox(width: 4),
                            Text(
                              workshop.workshops.first.instructorName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: context.getWidth(divideBy: 1.85),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  const SizedBox(width: 4),
                                  Text(
                                    date != null && date!.isNotEmpty
                                        ? date!
                                        : workshop.workshops.first.date,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              isAttended == true
                                  ? SizedBox(
                                      width: context.getWidth(divideBy: 7),
                                      height: context.getHeight(divideBy: 27),
                                      child: TextButton(
                                          onPressed: () => ratingDialog(
                                              context: context,
                                              workshop: workshop),
                                          style: TextButton.styleFrom(
                                              foregroundColor:
                                                  Constants.backgroundColor,
                                              alignment: Alignment.center,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      149, 222, 101, 49),
                                              side: const BorderSide(
                                                  color: Constants.mainOrange),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5))),
                                          child: Text("Rate".tr())),
                                    )
                                  : Row(
                                      children: [
                                        const Icon(HugeIcons.strokeRoundedUser,
                                            size: 16,
                                            color: Constants.lightGreen),
                                        const SizedBox(width: 4),
                                        Row(
                                          children: [
                                            Text(
                                                "${price ?? workshop.workshops.first.price}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                            const SizedBox(width: 5),
                                            Text("SR".tr())
                                          ],
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
  }
}
