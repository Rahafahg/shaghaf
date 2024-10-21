import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/user_screens/categories/user_cokking_categori_screen.dart';
import 'package:shaghaf/widgets/cards/user_category_cards.dart';
// Example import

class UserCategoriesScreen extends StatelessWidget {
  UserCategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      "title": "Pottery",
      "image": "assets/images/categories/pottery.png",
      "screento": UserCokkingCategoriScreen(), // Use the actual widget here
    },
    {
      "title": "Art",
      "image": "assets/images/categories/art.png",
      "screento": UserCokkingCategoriScreen(),
    },
    {
      "title": "Cook",
      "image": "assets/images/pasta_workshop.png",
      "screento": UserCokkingCategoriScreen(),
    },
    {
      "title": "Photography",
      "image": "assets/images/categories/Photography.png",
      "screento": UserCokkingCategoriScreen(),
    },
    {
      "title": "Handicrafts",
      "image": "assets/images/categories/Handicrafts.png",
      "screento": UserCokkingCategoriScreen(),
    },
    {
      "title": "Social Skills",
      "image": "assets/images/categories/social.png",
      "screento": UserCokkingCategoriScreen(),
    },
    {
      "title": "Fashion",
      "image": "assets/images/categories/fashion.png",
      "screento": UserCokkingCategoriScreen(),
    },
    {
      "title": "Others",
      "image": "assets/images/categories/others.png",
      "screento": UserCokkingCategoriScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 100,
          alignment: Alignment.centerLeft,
        ),
      ),
      backgroundColor: Constants.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.2
                  ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  screento: categories[index]['screento'],
                  title: categories[index]['title'],
                  imagePath: categories[index]['image'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
