import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Widget screento;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.screento,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the provided screen
        context.push(screen: screento);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: context.getWidth(divideBy: 2.2),
              height: context.getHeight(divideBy: 3.5),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              width: context.getWidth(divideBy: 2.2),
              height: context.getHeight(divideBy: 3.5),
            ),
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Constants.backgroundColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
