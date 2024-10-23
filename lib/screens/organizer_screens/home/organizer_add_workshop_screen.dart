import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaghaf/constants/constants.dart';

class OrganizerAddWorkshopScreen extends StatelessWidget {
  const OrganizerAddWorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Center(child: 
      Text("the Organizer can add workshop"),),
    );
  }
}