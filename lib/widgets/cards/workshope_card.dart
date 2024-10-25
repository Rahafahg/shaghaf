import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/widgets/effects/shimmer.dart';
import 'package:shimmer/shimmer.dart';

class WorkshopCard extends StatelessWidget {
  final WorkshopGroupModel workshop;
  final String shape;
  final Function()? onTap;
  final String? date;
  final double? price;
  const WorkshopCard(
      {super.key,
      required this.workshop,
      this.shape = 'square',
      this.onTap,
      this.date,
      this.price});

  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   onTap: onTap,
    //   child: shape=='square' ? Container(
    //     width: context.getWidth(divideBy: 2.3),
    //     height: context.getHeight(divideBy: 3),
    //     decoration: BoxDecoration(
    //       color: Colors.green,
    //       borderRadius: BorderRadius.circular(10.0),
    //       image: DecorationImage(
    //         image: workshop.image.isNotEmpty ? Image.network(workshop.image).image : const AssetImage("assets/images/pasta_workshop.png"),
    //         fit: BoxFit.cover,
    //       ),
    //       boxShadow: [BoxShadow(color: Colors.grey.shade300,blurRadius: 4,offset: const Offset(4, 8))],
    //     ),
    //     child: Column(
    //       children: [
    //         const Spacer(),
    //         Container(
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
    //             color: Constants.cardColor,
    //           ),
    //           width: context.getWidth(),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   workshop.title,
    //                   style: const TextStyle(fontFamily: "Poppins",fontSize: 12,fontWeight: FontWeight.w200,overflow: TextOverflow.ellipsis),
    //                 ),
    //                 Text(
    //                   GetIt.I.get<DataLayer>().categories.firstWhere((category)=>category.categoryId==workshop.categoryId).categoryName,
    //                   style: const TextStyle(fontSize: 10, fontFamily: "Poppins", fontWeight: FontWeight.w300),
    //                 ),
    //                 const SizedBox(height: 5),
    //                 Row(
    //                   children: [
    //                     const Icon(Icons.calendar_today,size: 16, color: Colors.grey),
    //                     const SizedBox(width: 4),
    //                     Text(
    //                       workshop.workshops.isEmpty ? 'handle me later' : workshop.workshops.first.date,
    //                       style: const TextStyle(fontFamily: "Poppins", fontSize: 8, fontWeight: FontWeight.w300),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 5),
    //                 Row(
    //                   children: [
    //                     const Icon(Icons.star, size: 16, color: Colors.orange),
    //                     const SizedBox(width: 4),
    //                     Text(workshop.rating.toString(),style: const TextStyle(fontFamily: "Poppins", fontSize: 8)),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    //   :
    //   Container(
    //     alignment: Alignment.center,
    //     width: context.getWidth(divideBy: 1.1),
    //     height: context.getHeight(divideBy: 6.2),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       color: Constants.cardColor,
    //       border: Border.all(color: Constants.appGreyColor),
    //       boxShadow: [BoxShadow(color: Colors.grey.shade300,blurRadius: 4,offset: const Offset(4, 8))],
    //     ),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         ClipRRect(
    //           borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
    //           child: SizedBox(
    //             width: context.getWidth(divideBy: 3.5),
    //             child: workshop.image.isNotEmpty ? Image.network(workshop.image, fit: BoxFit.cover,) : Image.asset("assets/images/pasta_workshop.png",),
    //           )
    //         ),
    //         const SizedBox(width: 10),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(
    //               width: context.getWidth(divideBy: 1.85),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   SizedBox(
    //                     width: context.getWidth(divideBy: 2.5),
    //                     child: Text(
    //                       workshop.title,
    //                       maxLines: 1,
    //                       overflow: TextOverflow.ellipsis,
    //                       style: const TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       const Icon(Icons.star, size: 16, color: Colors.orange),
    //                       const SizedBox(width: 4),
    //                       Text(workshop.rating.toString(),
    //                           style: Theme.of(context).textTheme.bodySmall),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Text(
    //               GetIt.I.get<DataLayer>().categories.firstWhere((category)=>category.categoryId == workshop.categoryId).categoryName,
    //               style: const TextStyle(fontSize: 14, color: Constants.mainOrange),
    //             ),
    //             Row(
    //               children: [
    //                 CircleAvatar(
    //                     radius: 12,
    //                     child: workshop.workshops.first.instructorImage.isNotEmpty ? Image.network(workshop.workshops.first.instructorImage) : Image.asset(
    //                         "assets/images/default_organizer_image.png")),
    //                 const SizedBox(width: 4),
    //                 Text(
    //                   workshop.workshops.first.instructorName,
    //                   style: Theme.of(context).textTheme.bodySmall,
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               width: context.getWidth(divideBy: 1.85),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       const Icon(Icons.calendar_today,
    //                           size: 16, color: Colors.grey),
    //                       const SizedBox(width: 4),
    //                       Text(
    //                         workshop.workshops.first.date,
    //                         style: Theme.of(context).textTheme.bodySmall,
    //                       ),
    //                     ],
    //                   ),
    //                   Row(
    //                     children: [
    //                       const Icon(HugeIcons.strokeRoundedUser,
    //                           size: 16, color: Constants.lightGreen),
    //                       const SizedBox(width: 4),
    //                       Text("${workshop.workshops.first.price} SR",
    //                           style: Theme.of(context).textTheme.bodySmall),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   )
    // );

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
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(4, 2))
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: SizedBox(
                        height: 100,
                        width: context.getWidth(divideBy: 2.3),
                        child: workshop.image.isNotEmpty
                            ? Image.network(
                                workshop.image,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    loadingProgress == null
                                        ? child
                                        : shimmerEffect(),
                              )
                            : Image.asset(
                                "assets/images/pasta_workshop.png"), // placeholder
                      ),
                    ),
                    Positioned(
                      top: 90,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Constants.cardColor),
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
                                  const Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
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
                                  Text(workshop.rating.toString(),
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
                  color: Constants.cardColor,
                  border: Border.all(color: Constants.appGreyColor),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(4, 8))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: SizedBox(
                          width: context.getWidth(divideBy: 3.5),
                          child: SizedBox(
                            width: context.getWidth(),
                            height: context.getHeight(),
                            child: workshop.image.isNotEmpty
                                ? Image.network(
                                    workshop.image,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            loadingProgress == null
                                                ? child
                                                : CircularProgressIndicator(),
                                  )
                                : Image.asset(
                                    "assets/images/pasta_workshop.png"), // placeholder
                          ),
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
                                  Text(workshop.rating.toString(),
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
                                child: workshop.workshops.first.instructorImage
                                        .isNotEmpty
                                    ? Image.network(
                                        workshop
                                            .workshops.first.instructorImage,
                                        loadingBuilder: (context, child,
                                                loadingProgress) =>
                                            loadingProgress == null
                                                ? child
                                                : Image.asset(
                                                    "assets/images/default_organizer_image.png"),
                                      )
                                    : Image.asset(
                                        "assets/images/default_organizer_image.png")),
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
                                  const Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
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
                              Row(
                                children: [
                                  const Icon(HugeIcons.strokeRoundedUser,
                                      size: 16, color: Constants.lightGreen),
                                  const SizedBox(width: 4),
                                  Text(
                                      "${price ?? workshop.workshops.first.price} SR",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
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
