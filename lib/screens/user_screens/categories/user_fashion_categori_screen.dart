import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/widgets/cards/my_workshop_card.dart';

class UserFashionCategoriScreen extends StatelessWidget {
  const UserFashionCategoriScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Constants.lightGreen,
              ),
            ),
            forceMaterialTransparency: true,
            centerTitle: true,
            title: const Text(
              "Fashion",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  color: Constants.textColor),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Divider(height: 1),
              ),
            )),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // MyWorkShopsCard(),
            ],
          ),
        ));
  }
}
