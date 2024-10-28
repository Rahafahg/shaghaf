import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      width: 200.0,
      height: 200.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.yellow.shade100,
        child: Container(
          width: 200.0,
          height: 200.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
