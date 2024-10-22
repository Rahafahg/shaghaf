import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/workshop_detail_screen.dart';

class WorkshopCard extends StatelessWidget {
  final WorkshopGroupModel workshop;
  final String shape;
  final Function()? onTap;
  const WorkshopCard(
      {super.key, required this.workshop, this.shape = 'square', this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: shape == 'square'
          ? Container(
              width: context.getWidth(divideBy: 2.3),
              height: context.getHeight(divideBy: 3.5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: workshop.image.isNotEmpty
                      ? Image.network(
                          workshop.image,
                          loadingBuilder: (context, child, loadingProgress) =>
                              const CircularProgressIndicator(),
                        ).image
                      : const AssetImage("assets/images/pasta_workshop.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Constants.cardColor,
                    ),
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
                  )
                ],
              ),
            )
          : Container(
              width: 100,
              height: 100,
              color: Colors.yellow,
            ),
    );
  }
}
