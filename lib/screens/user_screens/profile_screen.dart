import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/widgets/chapes/profile_shape.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.getWidth(),
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(context.getWidth(), 200),
                  painter: RPSCustomPainter(),
                ),
                CircleAvatar()
              ],
            ),
          )
        ],
      ),
    );
  }
}
