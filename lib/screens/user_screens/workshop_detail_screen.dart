import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shaghaf/models/workshop_group_model.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final WorkshopGroupModel workshop;
  const WorkshopDetailScreen({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    log('message');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: List.generate(workshop.workshops.length, (index){
              return Text(workshop.workshops[index].date);
            }),
          ),
        ),
      ),
    );
  }
}