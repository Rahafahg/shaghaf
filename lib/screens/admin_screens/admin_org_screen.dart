import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/admin_screens/bloc/admin_bloc.dart';

class AdminOrgScreen extends StatelessWidget {
  const AdminOrgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is ErrorState) {
              return Center(child: Text(state.msg,style: const TextStyle(fontFamily: "Poppins", fontSize: 20)));
            }
            if (state is LoadingState) {
              return Center(child: LottieBuilder.asset("assets/lottie/loading.json"));
            }
            if (state is SuccessState) {
              Map<String, int> organizersRating = GetIt.I.get<DataLayer>().organizersRating;
              List<int> vals = organizersRating.values.toList();
              vals.sort((v1,v2)=>v1.compareTo(v2));
              int maxY = vals.last + 2;
              getOrgProfit();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Organizers Statistics'.tr(context: context), style: const TextStyle(fontSize: 24)),
                      Container(
                        width: context.getWidth(),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                          color: Constants.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 10)]
                        ),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text("Most Rated Organizers".tr(context: context)),
                            const SizedBox(height: 20,),
                            SizedBox(
                              height: 300,
                              width: context.getWidth(),
                              child: BarChart(
                                BarChartData(
                                  maxY: maxY.toDouble(),
                                  barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBorder: const BorderSide(color: Colors.black45),
                                      tooltipPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                                      tooltipRoundedRadius: 20,
                                      getTooltipColor: (group) => Colors.white,
                                    )
                                  ),
                                  alignment: BarChartAlignment.spaceAround,
                                  titlesData: const FlTitlesData(
                                    topTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 80,showTitles: true,getTitlesWidget: bottomTitles,))
                                  ),
                                  backgroundColor: Constants.categoryColor_1.withOpacity(.3),
                                  barGroups: List.generate(organizersRating.length, (index){
                                    return BarChartGroupData(
                                      x: index,
                                      barRods: [BarChartRodData(width: 10,borderRadius: const BorderRadius.all(Radius.zero),toY: organizersRating[organizersRating.keys.toList()[index]]!.toDouble(),color: Constants.mainOrange)]
                                    );
                                  })
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: context.getWidth(),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                          color: Constants.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 10)]
                        ),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text("Most Profit Organizers".tr(context: context)),
                            const SizedBox(height: 20,),
                            SizedBox(
                              height: 300,
                              width: context.getWidth(),
                              child: LineChart(
                                LineChartData(
                                  minX: 0,
                                  minY: 0,
                                  titlesData: const FlTitlesData(
                                    topTitles: AxisTitles(),
                                    // bottomTitles: AxisTitles()
                                  ),
                                  // lineTouchData: LineTouchData(
                                  //   touchTooltipData: LineTouchTooltipData(
                                  //     tooltipBorder: const BorderSide(color: Colors.black45),
                                  //     tooltipPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                                  //     tooltipRoundedRadius: 20,
                                  //     getTooltipColor: (group) => Colors.white,
                                  //   )
                                  // ),
                                  backgroundColor: Constants.categoryColor_1.withOpacity(.3),
                                  lineBarsData: [
                                    LineChartBarData(
                                      color: Constants.mainOrange,
                                      spots: [
                                        const FlSpot(0, 1),
                                        const FlSpot(1, 4),
                                        const FlSpot(2, 6),
                                        const FlSpot(3, 3),
                                        const FlSpot(4, 4),
                                      ]
                                    ),
                                    LineChartBarData(
                                      spots: [
                                        const FlSpot(0, 2),
                                        const FlSpot(1, 3),
                                        const FlSpot(2, 1),
                                        const FlSpot(3, 2),
                                        const FlSpot(4, 6),
                                      ]
                                    )
                                  ]
                                )
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(width: 5,height: 5,color: Constants.mainOrange,),
                                      const SizedBox(width: 10,),
                                      const Text("nn")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(width: 5,height: 5,color: Colors.blue,),
                                      const SizedBox(width: 10,),
                                      const Text("nn2")
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text("Something went wrong"),);
          },
        ),
      ),
    );
  }
}

Widget bottomTitles(double value, TitleMeta meta) {
  String text = '';
  text = GetIt.I.get<DataLayer>().organizersRating.keys.toList()[value.toInt()];
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: RotatedBox(quarterTurns: 3, child: Text(text, style: const TextStyle(fontSize: 10))),
  );
}