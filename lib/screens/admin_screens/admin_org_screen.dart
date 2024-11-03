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
              List<WorkshopGroupModel> workshops = GetIt.I.get<DataLayer>().allWorkshops;
              log(workshops.length.toString());
              List<BookingModel> bookings = GetIt.I.get<DataLayer>().bookings;
              log(bookings.length.toString());
              List<CategoriesModel> categories = GetIt.I.get<DataLayer>().categories;
              Map<String, List<WorkshopGroupModel>> categoriesMap = GetIt.I.get<DataLayer>().workshopsByCategory;
              getBookedCategories();
              Map<String, int> bookedCategories = GetIt.I.get<DataLayer>().bookedCategories;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categories Statistics'.tr(context: context), style: const TextStyle(fontSize: 24)),
                      Container(
                        width: context.getWidth(),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Constants.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 10)]
                        ),
                        child: Column(
                          children: [
                            Text("Number of workshops by category".tr(context: context)),
                            const SizedBox(height: 20,),
                            SizedBox(
                              height: 200,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 0,
                                  sections: List.generate(categories.length, (index){
                                    return PieChartSectionData(
                                      value: categoriesMap[categories[index].categoryName]!.length.toDouble(),
                                      color: colors[index],
                                      radius: 100,
                                      title: categoriesMap[categories[index].categoryName]!.length.toString()
                                    );
                                  })
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // GridView.builder(
                            //   shrinkWrap: true,
                            //   itemCount: categories.length,
                            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 0),
                            //   itemBuilder: (context, index) {
                            //     return Row(
                            //       children: [
                            //         Container(width: 5,height: 5,color: colors[index],),
                            //         const SizedBox(width: 10,),
                            //         Text(categories[index].categoryName)
                            //       ],
                            //     );
                            //   }
                            // )
                            Column(
                              // spacing: 15,
                              // overflowAlignment: OverflowBarAlignment.center,
                              children: List.generate(categories.length, (index){
                                return Row(
                                  children: [
                                    Container(width: 5,height: 5,color: colors[index],),
                                    const SizedBox(width: 10,),
                                    Text(categories[index].categoryName)
                                  ],
                                );
                              }),
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
                            Text("Most Booked Categories".tr(context: context)),
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
                                  barGroups: List.generate(bookedCategories.length, (index){
                                    return BarChartGroupData(
                                      x: bookedCategories[categoriesMap.keys.toList()[index]]!,
                                      barRods: [
                                        BarChartRodData(
                                          width: 10,
                                          borderRadius: const BorderRadius.all(Radius.zero),
                                          toY: bookedCategories[categoriesMap.keys.toList()[index]]!.toDouble(),
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
  for (var key in GetIt.I.get<DataLayer>().bookedCategories.keys) {
    List<String> appeared = [];
    if(GetIt.I.get<DataLayer>().bookedCategories[key]!.toDouble() == value) {
      text = key;
      appeared.add(key);
    }
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: RotatedBox(quarterTurns: 3,child: Text(text, style: style)),
  );
}