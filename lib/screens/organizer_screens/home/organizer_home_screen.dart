import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/screens/organizer_screens/home/organizer_navigation_screen.dart/organizer_navigation.dart';

class OrganizerHomeScreen extends StatelessWidget {
  const OrganizerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 100,
          alignment: Alignment.centerLeft, // Align logo to the left
        ),
      ),
      body: SafeArea(
          child:
              Center(child: Text("welcom Organizer"))
             
              ),
    );
  }
}
