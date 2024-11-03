import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/organizer_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/admin_screens/bloc/admin_bloc.dart';

class AdminOrgScreen extends StatelessWidget {
  const AdminOrgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.lime, Colors.blueGrey, Colors.brown, Colors.purple];
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
              List<OrganizerModel> organizers = GetIt.I.get<DataLayer>().organizers;
              Map<String, int> organizersRating = GetIt.I.get<DataLayer>().organizersRating;
              log(organizersRating.toString());
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
                                  alignment: BarChartAlignment.spaceAround,
                                  titlesData: const FlTitlesData(
                                    topTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 80,
                                        showTitles: true,
                                        getTitlesWidget: bottomTitles,
                                      )
                                    )
                                  ),
                                  backgroundColor: Constants.categoryColor_1.withOpacity(.3),
                                  barGroups: List.generate(organizersRating.length, (index){
                                    log('message heeeeeeeeeeeeeeeeeere');
                                    log(organizersRating.keys.toList()[index]);
                                    log(organizersRating[organizersRating.keys.toList()[index]].toString());
                                    return BarChartGroupData(
                                      x: organizersRating[organizersRating.keys.toList()[index]]!,
                                      barRods: [
                                        BarChartRodData(
                                          width: 10,
                                          borderRadius: const BorderRadius.all(Radius.zero),
                                          toY: organizersRating[organizersRating.keys.toList()[index]]!.toDouble(),
                                          color: Constants.mainOrange
                                        )
                                      ]
                                    );
                                  })
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50,),
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
  const style = TextStyle(fontSize: 10);
  String text = '';
  log('start');
  for (var key in GetIt.I.get<DataLayer>().organizersRating.keys) {
    log(key);
    List<String> appeared = [];
    log(GetIt.I.get<DataLayer>().organizersRating[key].toString());
    log(value.toString());
    if(GetIt.I.get<DataLayer>().organizersRating[key]! == value) {
      text = key;
      appeared.add(key);
    }
  }
  log('end');
  log('--------');
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: RotatedBox(quarterTurns: 3,child: Text(text, style: style)),
  );
}