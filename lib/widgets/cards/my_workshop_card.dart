import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/workshop_detail_screen.dart';

class MyWorkShopsCard extends StatelessWidget {
  final WorkshopGroupModel workshop;
  const MyWorkShopsCard({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(screen: WorkshopDetailScreen(workshop: workshop)),
      child: Container(
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
              offset: const Offset(4, 8), // Shadow position
            ),
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
                  child: workshop.image.isNotEmpty ? Image.network(workshop.image, fit: BoxFit.cover,) : Image.asset(
                    "assets/images/pasta_workshop.png",
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(workshop.rating.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  GetIt.I.get<DataLayer>().categories.firstWhere((category)=>category.categoryId == workshop.categoryId).categoryName,
                  style: TextStyle(fontSize: 14, color: Constants.mainOrange),
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        child: workshop.workshops.first.instructorImage.isNotEmpty ? Image.network(workshop.workshops.first.instructorImage) : Image.asset(
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
                            workshop.workshops.first.date,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(HugeIcons.strokeRoundedUser,
                              size: 16, color: Constants.lightGreen),
                          const SizedBox(width: 4),
                          Text("${workshop.workshops.first.price} SR",
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}