

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();

    // Start from the top-left corner
    path_0.moveTo(0, 0);

    // Curves starting from the left to middle
    path_0.cubicTo(
        0,
        0,
        size.width * 0.11,
        size.height * 0.14, // Adjusted control point for left side curve
        size.width * 0.22,
        size.height * 0.15 // Control points that define the curve
        );
    path_0.cubicTo(
        size.width * 0.33,
        size.height * 0.15, // Adjust control points to match desired curve
        size.width * 0.5,
        size.height * 0.15, // Move to mid-right
        size.width * 0.51,
        size.height * 0.15);

    // The curve for the top-right corner to give it a rounded effect
    path_0.cubicTo(
        size.width * 0.88,
        size.height * 0.16, // Control points for top-right corner curve
        size.width,
        size.height * 0.39, // Define the curve towards the bottom-right
        size.width,
        size.height * 0.6);

    // Line down to the bottom-right corner
    path_0.lineTo(size.width, size.height);

    // Line across the bottom of the screen
    path_0.lineTo(0, size.height);

    // Close the path
    path_0.close();

    // Paint the path
    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = const Color(0xffFFFCEB).withOpacity(1.0);
    canvas.drawPath(path_0, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  } 
}
