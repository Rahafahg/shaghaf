import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
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
            bottom: PreferredSize(
                preferredSize: Size(double.infinity, 60),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Divider(),
                      SizedBox(height: 10),
                      TabBar(
                        overlayColor: WidgetStatePropertyAll(Colors.transparent),
                        labelColor: Constants.backgroundColor,
                        splashBorderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        indicator: BoxDecoration(
                          color: const Color.fromARGB(165, 222, 101, 49),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        indicatorPadding:
                            const EdgeInsets.symmetric(vertical: 1),
                        tabs: [
                          TapCustomStyle(
                            title: "Incoming",
                          ),
                          TapCustomStyle(
                            title: "Previous",
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          body: TabBarView(children: [
            Text(GetIt.I.get<DataLayer>().bookings.length.toString()),
            Text(GetIt.I.get<DataLayer>().bookings.length.toString())
          ])),
    );
  }
}
