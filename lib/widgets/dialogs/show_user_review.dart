import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/user_review_model.dart';

class ShowUserReview extends StatelessWidget {
  const ShowUserReview({
    super.key,
    required this.review,
  });

  final UserReviewModel review;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        constraints:
            BoxConstraints(
          minHeight: context
              .getHeight(
                  divideBy:
                      4),
          maxHeight: context
              .getHeight(
                  divideBy:
                      3),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            const SizedBox(
                height: 7),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [
                SizedBox(
                  width: context.getWidth(divideBy: 2),
                  child: Text(
                    '${review.userFName} ${review.userLName}',
                    style: const TextStyle(
                        color:
                            Constants.mainOrange),
                            overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .end,
                  children: [
                    const Icon(
                        Icons
                            .star,
                        size:
                            16,
                        color:
                            Colors.orange),
                    Text(review
                        .rate
                        .toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(
                height: 10),
            // Wrapping the comment in a Flexible widget to handle overflow
            Expanded(
              child:
                  SingleChildScrollView(
                child: Text(
                    review
                        .comment),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
