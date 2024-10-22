import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/widgets/cards/my_workshop_card.dart';
import 'package:shaghaf/widgets/tapbar/tap_custom.dart';

class MyWorkshopsScreen extends StatelessWidget {
  const MyWorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: const Text(
              "My Workshops",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  color: Constants.textColor),
            ),
            bottom: const PreferredSize(
                preferredSize: Size(double.infinity, 60),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Divider(),
                      SizedBox(height: 10),
                      TabBar(
                          splashBorderRadius:
                              BorderRadius.all(Radius.circular(10)),
                          tabs: [
                            TapCustomStyle(title: "Incoming"),
                            TapCustomStyle(title: "Previous"),
                          ]),
                    ],
                  ),
                )),
          ),
          body: const TabBarView(children: [
            Column(children: [SizedBox(height: 27),]),
            Column(children: [SizedBox(height: 27),]),
          ])),
    );
  }
}
