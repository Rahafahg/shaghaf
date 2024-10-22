import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  final double width;

  RPSCustomPainter({super.repaint, required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    double scale = width / 400;
    Path path_0 = Path();
    path_0.moveTo(200 * scale, 200 * scale);
    path_0.cubicTo(310.457 * scale, 200 * scale, 400 * scale, 110.457 * scale,
        400 * scale, 0);
    path_0.lineTo(0, 0);
    path_0.cubicTo(0, 110.457 * scale, 89.5431 * scale, 200 * scale,
        200 * scale, 200 * scale);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xffF8EEE9).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(247.332, 90.6568);
    path_1.cubicTo(239.313, 95.067, 232.699, 99.6982, 228.54, 105.578);
    path_1.cubicTo(226.957, 107.829, 225.061, 109.923, 220.749, 110.31);
    path_1.cubicTo(216.713, 110.668, 214.118, 108.584, 216.297, 106.212);
    path_1.cubicTo(222.477, 99.5086, 228.708, 92.7674, 238.323, 87.5557);
    path_1.cubicTo(246.073, 83.3471, 252.849, 83.2332, 258.477, 87.2308);
    path_1.cubicTo(262.703, 90.2165, 264.291, 90.2442, 270.156, 87.0976);
    path_1.cubicTo(275.713, 84.1054, 281.039, 80.9211, 286.687, 78.0117);
    path_1.cubicTo(294.169, 74.1607, 301.849, 71.9426, 310.511, 73.6248);
    path_1.cubicTo(312.818, 74.0673, 317.02, 73.2157, 319.322, 72.0321);
    path_1.cubicTo(327.191, 67.9741, 334.83, 63.6592, 342.082, 59.1103);
    path_1.cubicTo(345.623, 56.8943, 348.608, 57.034, 352.137, 57.2379);
    path_1.cubicTo(354.305, 57.3593, 356.659, 57.4521, 358.854, 57.0532);
    path_1.cubicTo(361.893, 56.5109, 365.016, 56.025, 365.579, 58.1446);
    path_1.cubicTo(365.836, 59.122, 363.817, 60.9743, 362.178, 61.9314);
    path_1.cubicTo(360.302, 63.0287, 357.543, 64.222, 355.425, 64.2743);
    path_1.cubicTo(345.868, 64.5199, 339.857, 69.2125, 333.358, 73.1679);
    path_1.cubicTo(327.448, 76.7554, 321.193, 79.5121, 313.681, 80.3726);
    path_1.cubicTo(311.11, 80.664, 308.254, 81.0129, 306.07, 80.5915);
    path_1.cubicTo(301.653, 79.7309, 297.795, 80.3106, 293.781, 82.5304);
    path_1.cubicTo(288.996, 85.1732, 284.208, 87.807, 279.258, 90.2902);
    path_1.cubicTo(275.701, 92.0681, 272.052, 93.9014, 268.14, 95.163);
    path_1.cubicTo(261.163, 97.4226, 254.991, 96.5776, 250.752, 93.3096);
    path_1.cubicTo(249.666, 92.4726, 248.592, 91.6239, 247.346, 90.6539);
    path_1.lineTo(247.332, 90.6568);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xffDE6431).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(137.046, 95);
    path_2.cubicTo(139.668, 96.5522, 142.707, 97.364, 143.571, 99.1298);
    path_2.cubicTo(144.406, 100.853, 143.631, 103.943, 142.439, 105.766);
    path_2.cubicTo(139.787, 109.867, 136.166, 113.385, 133.44, 117.458);
    path_2.cubicTo(131.533, 120.292, 130.863, 123.88, 128.926, 126.7);
    path_2.cubicTo(125.812, 131.229, 122.341, 135.601, 118.512, 139.588);
    path_2.cubicTo(117.722, 140.414, 113.476, 139.901, 112.91, 138.904);
    path_2.cubicTo(111.301, 136.127, 109.17, 132.126, 110.183, 129.776);
    path_2.cubicTo(112.492, 124.436, 116.515, 119.779, 119.927, 114.88);
    path_2.cubicTo(123.532, 109.711, 127.063, 104.484, 130.952, 99.5286);
    path_2.cubicTo(132.338, 97.7627, 134.706, 96.6947, 137.046, 95);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = const Color(0xff62B379).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(341.478, 127.793);
    path_3.cubicTo(341.865, 133.545, 337.576, 140.187, 331.882, 146.197);
    path_3.cubicTo(328.754, 149.511, 325.957, 148.019, 323.332, 145.538);
    path_3.cubicTo(320.721, 143.056, 321.41, 141.076, 323.877, 138.595);
    path_3.cubicTo(331.121, 131.308, 332.656, 123.447, 328.381, 116.432);
    path_3.cubicTo(327.162, 114.424, 325.183, 112.76, 323.26, 111.34);
    path_3.cubicTo(321.31, 109.891, 318.699, 109.274, 316.92, 107.668);
    path_3.cubicTo(314.568, 105.559, 311.512, 103.149, 313.635, 99.305);
    path_3.cubicTo(315.801, 95.3746, 319.445, 95.1594, 322.586, 97.555);
    path_3.cubicTo(331.781, 104.526, 341.435, 111.369, 341.464, 127.793);
    path_3.lineTo(341.478, 127.793);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = const Color(0xffF2B330).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(254.3, 146);
    path_4.cubicTo(250.072, 143.5, 246.287, 141.945, 243.444, 139.286);
    path_4.cubicTo(242.086, 138.021, 241.406, 133.647, 242.377, 132.484);
    path_4.cubicTo(243.985, 130.551, 247.826, 128.546, 249.559, 129.345);
    path_4.cubicTo(252.179, 130.551, 253.496, 129.577, 255.395, 128.647);
    path_4.cubicTo(258.64, 127.049, 261.842, 126.046, 265.35, 128.371);
    path_4.cubicTo(268.733, 130.609, 270.285, 134.548, 267.429, 137.193);
    path_4.cubicTo(263.714, 140.623, 259.042, 142.919, 254.328, 145.985);
    path_4.lineTo(254.3, 146);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = const Color(0xffDC0D17).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(202.92, 76.7393);
    path_5.cubicTo(202.848, 81.4103, 200.065, 82.3798, 197.181, 82.7323);
    path_5.cubicTo(185.417, 84.1278, 173.638, 85.4791, 161.845, 86.5367);
    path_5.cubicTo(157.8, 86.9039, 153.18, 88.1524, 150.124, 83.9955);
    path_5.cubicTo(149.192, 82.7323, 148.546, 80.1618, 149.163, 78.9426);
    path_5.cubicTo(153.912, 69.6741, 158.99, 60.5818, 163.983, 51.4455);
    path_5.cubicTo(165.504, 48.6693, 166.494, 45.2028, 168.746, 43.3667);
    path_5.cubicTo(171.228, 41.3543, 174.815, 40.4436, 178.057, 40.003);
    path_5.cubicTo(178.918, 39.8855, 180.166, 43.2932, 181.343, 45.0118);
    path_5.cubicTo(187.182, 53.5019, 193.064, 61.9478, 198.903, 70.4379);
    path_5.cubicTo(200.309, 72.4943, 201.586, 74.6389, 202.92, 76.754);
    path_5.lineTo(202.92, 76.7393);
    path_5.close();
    path_5.moveTo(185.202, 72.2152);
    path_5.cubicTo(181.601, 66.1341, 178.531, 60.9637, 174.786, 54.6623);
    path_5.cubicTo(171.644, 61.2134, 168.961, 66.3985, 166.809, 71.7892);
    path_5.cubicTo(166.523, 72.509, 169.062, 75.5936, 170.052, 75.4614);
    path_5.cubicTo(174.772, 74.8592, 179.42, 73.5372, 185.202, 72.2152);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = const Color(0xffB3A0FF).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(162.922, 141.549);
    path_6.cubicTo(163.041, 136.462, 167.074, 136.254, 170.541, 136.017);
    path_6.cubicTo(174.916, 135.72, 176.106, 139.457, 175.898, 142.542);
    path_6.cubicTo(175.764, 144.5, 173.279, 147.718, 171.597, 147.881);
    path_6.cubicTo(165.094, 148.534, 162.848, 146.502, 162.922, 141.534);
    path_6.lineTo(162.922, 141.549);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = const Color(0xffF38C9D).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(255.922, 63.5486);
    path_7.cubicTo(256.041, 58.4615, 260.074, 58.2539, 263.541, 58.0166);
    path_7.cubicTo(267.916, 57.72, 269.106, 61.4574, 268.898, 64.5423);
    path_7.cubicTo(268.764, 66.5, 266.279, 69.7183, 264.597, 69.8815);
    path_7.cubicTo(258.094, 70.534, 255.848, 68.5022, 255.922, 63.5338);
    path_7.lineTo(255.922, 63.5486);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = const Color(0xff7AC1DA).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(38.9219, 92.5486);
    path_8.cubicTo(39.041, 87.4615, 43.0736, 87.2539, 46.5407, 87.0166);
    path_8.cubicTo(50.9155, 86.72, 52.1059, 90.4574, 51.8976, 93.5423);
    path_8.cubicTo(51.7637, 95.5, 49.2786, 98.7183, 47.5971, 98.8815);
    path_8.cubicTo(41.0944, 99.534, 38.8475, 97.5022, 38.9219, 92.5338);
    path_8.lineTo(38.9219, 92.5486);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = const Color(0xff9747FF).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(279.334, 47.9974);
    path_9.cubicTo(271.673, 45.6741, 260.208, 33.8816, 259.826, 26.6752);
    path_9.cubicTo(259.658, 23.4437, 260.553, 19.3515, 264.623, 19.1709);
    path_9.cubicTo(266.149, 19.0976, 268.363, 22.4248, 269.338, 24.6102);
    path_9.cubicTo(271.927, 30.3919, 276.165, 34.4107, 281.966, 36.2382);
    path_9.cubicTo(283.876, 36.8471, 287.198, 35.5555, 288.771, 34.0113);
    path_9.cubicTo(291.473, 31.3569, 293.192, 27.7325, 295.552, 24.6833);
    path_9.cubicTo(296.888, 22.9424, 298.436, 21.0265, 300.333, 20.1667);
    path_9.cubicTo(301.922, 19.447, 304.654, 19.4966, 305.949, 20.4448);
    path_9.cubicTo(307.012, 21.2413, 307.63, 24.6269, 306.861, 25.5638);
    path_9.cubicTo(301.093, 32.5257, 295.238, 39.4837, 288.719, 45.7003);
    path_9.cubicTo(286.697, 47.6334, 282.518, 47.2923, 279.337, 47.9834);
    path_9.lineTo(279.334, 47.9974);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = const Color(0xffBDD12A).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(-16.6087, 11.4423);
    path_10.cubicTo(-25.7161, 10.5434, -33.7901, 10.6212, -40.5457, 13.1178);
    path_10.cubicTo(-43.1249, 14.0785, -45.873, 14.7328, -49.6471, 12.6129);
    path_10.cubicTo(-53.1784, 10.6253, -54.1394, 7.43835, -51.0002, 6.71519);
    path_10.cubicTo(-42.1126, 4.68283, -33.1611, 2.64824, -22.2839, 3.78913);
    path_10.cubicTo(-13.5129, 4.70185, -7.86068, 8.44063, -5.48025, 14.921);
    path_10.cubicTo(-3.68387, 19.7737, -2.39071, 20.6943, 4.2263, 21.4173);
    path_10.cubicTo(10.5014, 22.0931, 16.6946, 22.4797, 22.9977, 23.275);
    path_10.cubicTo(31.3459, 24.3313, 38.9337, 26.846, 45.1256, 33.1331);
    path_10.cubicTo(46.7776, 34.8028, 50.7248, 36.4775, 53.2929, 36.8038);
    path_10.cubicTo(62.0771, 37.908, 70.8173, 38.6707, 79.3705, 39.0213);
    path_10.cubicTo(83.5446, 39.1971, 85.9267, 41.0004, 88.7219, 43.165);
    path_10.cubicTo(90.4409, 44.4913, 92.3298, 45.8994, 94.3658, 46.8122);
    path_10.cubicTo(97.1781, 48.0836, 100.029, 49.4498, 99.2939, 51.5159);
    path_10.cubicTo(98.9532, 52.4674, 96.2404, 52.8528, 94.3476, 52.7152);
    path_10.cubicTo(92.1795, 52.5587, 89.2296, 51.9823, 87.4536, 50.8276);
    path_10.cubicTo(79.4331, 45.624, 71.8221, 46.094, 64.2246, 45.6792);
    path_10.cubicTo(57.3222, 45.295, 50.6046, 44.0302, 43.9235, 40.491);
    path_10.cubicTo(41.6378, 39.2766, 39.0854, 37.949, 37.5225, 36.366);
    path_10.cubicTo(34.3673, 33.1582, 30.8575, 31.4538, 26.2918, 31.014);
    path_10.cubicTo(20.8507, 30.4865, 15.4132, 29.9508, 9.92597, 29.1983);
    path_10.cubicTo(5.98746, 28.6526, 1.94153, 28.1006, -1.99849, 26.928);
    path_10.cubicTo(-9.02988, 24.8451, -13.6418, 20.6571, -15.2891, 15.5643);
    path_10.cubicTo(-15.7113, 14.2598, -16.1166, 12.9526, -16.5954, 11.4479);
    path_10.lineTo(-16.6087, 11.4423);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = const Color(0xffDE6431).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
