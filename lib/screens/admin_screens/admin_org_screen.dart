import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/models/booking_model.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/models/organizer_model.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/admin_screens/bloc/admin_bloc.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class AdminOrgScreen extends StatelessWidget {
  const AdminOrgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.lime, Colors.blueGrey, Colors.brown, Colors.purple];
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Image.asset(
            'assets/images/logo.png',
            height: 100,
            alignment: Alignment.centerLeft, // Align logo to the left
          ),),
      body: SafeArea(
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is ErrorState) {
              return Center(
                  child: Text(state.msg,
                      style: const TextStyle(
                          fontFamily: "Poppins", fontSize: 20)));
            }
            if (state is LoadingState) {
              return Center(
                  child: LottieBuilder.asset("assets/lottie/loading.json"));
            }
            if (state is SuccessState) {
              List<WorkshopGroupModel> workshops =
                  GetIt.I.get<DataLayer>().allWorkshops;
              List<BookingModel> bookings = GetIt.I.get<DataLayer>().bookings;
              List<CategoriesModel> categories =
                  GetIt.I.get<DataLayer>().categories;
                  Map<String, List<WorkshopGroupModel>> mapap = GetIt.I.get<DataLayer>().workshopsByCategory;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Top Organizers'),
                      Text(workshops.length.toString()),
                      Text(bookings.length.toString()),
                      Text(categories.length.toString()),
                      Text(mapap.length.toString()),
                      Container(
                        height: 200, // Specify a height for the chart
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: List.generate(categories.length, (index){
                              return PieChartSectionData(
                                value: mapap[categories[index].categoryName]!.length.toDouble(),
                                color: colors[index],
                                radius: 100,
                                title: mapap[categories[index].categoryName]!.length.toString()
                              );
                            })
                          ),
                        ),
                      ),
                      OverflowBar(
                        spacing: 15,
                        overflowAlignment: OverflowBarAlignment.center,
                        children: List.generate(categories.length, (index){
                          return Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                color: colors[index],
                              ),
                              Text(categories[index].categoryName)
                            ],
                          );
                        }),
                      ),
                      Container(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            // titlesData: FlTitlesData(
                            //   bottomTitles: AxisTitles(
                            //     // axisNameWidget: Text("jhg")
                            //     // axisNameWidget: Row(
                            //     //   mainAxisAlignment: MainAxisAlignment.center,
                            //     //   children: List.generate(categories.length, (index){
                            //     //     return Text(categories[index].categoryName, style: TextStyle(fontSize: 10),);
                            //     //   }),
                            //     // )
                            //   )
                            // ),
                            backgroundColor: Colors.yellow,
                            barGroups: List.generate(categories.length, (index){
                              return BarChartGroupData(
                                x: mapap[categories[index].categoryName]!.length,
                                barRods: [
                                  BarChartRodData(toY: mapap[categories[index].categoryName]!.length.toDouble())
                                ]
                              );
                            })
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          },
        ),
      ),
    );
  }
}