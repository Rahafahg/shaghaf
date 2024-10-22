import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/screens/user_screens/home/bloc/user_home_bloc.dart';

class ContainersTabBar extends StatelessWidget {
  final List<String> tabs;
  final String? selectedTab;
  void Function(int)? onTap;
  ContainersTabBar(
      {super.key,
      required this.tabs,
      required this.selectedTab,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    log(selectedTab?? "no cat");
    // tabs.contains(selectedTab) ? selectedTab : "All";
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: TabBar(
        onTap: onTap,
        tabAlignment: TabAlignment.start,
        overlayColor: WidgetStateColor.transparent,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicator: const BoxDecoration(
          color: Colors.transparent, // Removes any visible indicator
        ),
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        tabs: tabs.map((category) {
          final isSelected = selectedTab == category;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Constants.mainOrange : Colors.white,
                border: Border.all(color: Constants.mainOrange),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(category,
                      style: TextStyle(
                        color: isSelected
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : Constants.mainOrange,
                      )),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
