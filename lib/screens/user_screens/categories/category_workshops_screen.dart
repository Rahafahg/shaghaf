import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/screens/user_screens/categories/bloc/categories_bloc.dart';
import 'package:shaghaf/screens/user_screens/other/workshop_detail_screen.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';
import 'package:shaghaf/widgets/tapbar/containers_tab_bar.dart';
import 'package:shaghaf/widgets/text_fields/search_field.dart';

class CategoryWorkshopsScreen extends StatelessWidget {
  final CategoriesModel category;
  final CategoriesBloc bloc;
  const CategoryWorkshopsScreen({super.key, required this.category, required this.bloc});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight(divideBy: 13)),
          child: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios, color: Constants.lightGreen),
            ),
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              category.categoryName,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                color: Constants.textColor,
              ),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Padding(
                padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 6),
                child: Divider(height: 1),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.getWidth(divideBy: 1.3),
                      child: SearchField(
                        onChanged: (value) {
                          bloc.add(CategorySearchEvent(
                            searchTerm: value,
                            category: category,
                          ));
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: ()=>showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: context.getWidth(),
                            height: context.getHeight(divideBy: 1.5),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: const Color(0xffF4F4F4), borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Filter Workshops", style: TextStyle(fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.w500),),
                                    TextButton(onPressed: ()=>bloc.add(ResetFilterEvent()), child: Text("data"))
                                  ],
                                ),
                                // SizedBox(height: 16,),
                                const Divider(thickness: 1,),
                                SizedBox(height: 16,),
                                const Text("Day", style: TextStyle(fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500),),
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  width: context.getWidth(divideBy: 2),
                                  child: TextField(
                                    controller: bloc.dateController,
                                    onTap: () async => await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2023),
                                      lastDate: DateTime(2026)
                                    ).then((value) {
                                      // bloc.dateController.text = value.toString().split(' ').first;
                                      if(value==null){return;}
                                      if(value!=null) {
                                        log('hi');
                                        bloc.add(HandleDateEvent(date: value.toString().split(' ').first));
                                        log(bloc.dateController.text);
                                        log(value.toString());
                                      }
                                    },),
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'Select Date',
                                      prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar03, color: Constants.lightGreen),
                                      filled: true
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                const Text("Type", style: TextStyle(fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500),),
                                ContainersTabBar(
                                  tabs: const ['All', 'In-Site', 'Online'],
                                  selectedTab: 'All',
                                  onTap: (index)=>log("kkk")
                                ),
                                const SizedBox(height: 16,),
                                const Text("Ratings", style: TextStyle(fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500),),
                                ContainersTabBar(
                                  tabs: const ['All', 'Top-Rated'],
                                  selectedTab: 'All',
                                  onTap: (index)=>log("kkk")
                                ),
                                SizedBox(height: 16,),
                                const Text("Price Range (SAR)", style: TextStyle(fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500),),
                                BlocBuilder<CategoriesBloc, CategoriesState>(
                                  bloc: bloc,
                                  builder: (context, state) {
                                    return RangeSlider(
                                      values: RangeValues(bloc.minPrice, bloc.maxPrice),
                                      activeColor: Constants.mainOrange,
                                      inactiveColor: Constants.lightOrange.withOpacity(.3),
                                      labels: RangeLabels(bloc.minPrice.toString(), bloc.maxPrice.toString()),
                                      divisions: 20,
                                      max: 1000,
                                      min: 0,
                                      onChanged: (range)=> bloc.add(ChangePriceEvent(range: range))
                                    );
                                  },
                                )                            
                              ],
                            ),
                          );
                        },
                      ),
                      icon: const HugeIcon(icon: HugeIcons.strokeRoundedFilterHorizontal, color: Constants.lightGreen)
                    )
                  ],
                ),
                const SizedBox(height: 20),
                BlocBuilder<CategoriesBloc, CategoriesState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is ShowCategoryWorkshopsState) {
                      if (state.workshops.isEmpty) {
                        return const Text("No workshops available");
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => WorkshopCard(
                          workshop: state.workshops[index],
                          shape: 'rect',
                          onTap: () => context.push(
                            screen: WorkshopDetailScreen(workshop: state.workshops[index]),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                        itemCount: state.workshops.length,
                      );
                    }
                    return const Text('Something went wrong');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}