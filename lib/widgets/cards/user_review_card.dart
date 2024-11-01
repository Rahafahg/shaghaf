import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/models/user_review_model.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({
    super.key,
    required this.workshopReview,
    required this.index,
  });
  final int index;
  final List<UserReviewModel> workshopReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // width: context.getWidth(divideBy: 2),
      // height: context.getWidth(divideBy: 6),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              textAlign: TextAlign.start,
              style: const TextStyle(color: Constants.mainOrange),
              "${workshopReview[index].userFName} ${workshopReview[index].userLName}"),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(workshopReview[index].comment),
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(workshopReview[index].rate.toString(),
                      style:
                          const TextStyle(fontFamily: "Poppins", fontSize: 8)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
