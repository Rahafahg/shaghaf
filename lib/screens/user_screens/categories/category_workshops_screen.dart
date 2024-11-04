import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
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
    bloc.dateController.clear();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight(divideBy: 13)),
          child: AppBar(
            leading: IconButton(onPressed: () => context.pop(),icon: const Icon(Icons.arrow_back_ios, color: Constants.lightGreen)),
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              category.categoryName.tr(context: context),
              style: const TextStyle(fontSize: 20,color: Constants.textColor,),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.getWidth(divideBy: 1.3),
                        child: SearchField(onChanged: (value) => bloc.add(CategorySearchEvent(searchTerm: value, category: category))),
                      ),
                      IconButton(
                        icon: const HugeIcon(icon: HugeIcons.strokeRoundedFilterHorizontal,color: Constants.lightGreen),
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            width: context.getWidth(),
                            height: context.getHeight(divideBy: 1.5),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: const Color(0xffF4F4F4),borderRadius:BorderRadius.circular(20)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Filter Workshops".tr(),
                                        style: const TextStyle(fontFamily: "Poppins",fontSize: 20,fontWeight:FontWeight.w500),
                                      ),
                                      TextButton(
                                        onPressed: () => bloc.add(ResetFilterEvent()),
                                        child: Text("reset".tr(),style: const TextStyle(color: Constants.mainOrange,fontFamily:"Poppins"))
                                      )
                                    ],
                                  ),
                                  const Divider(thickness: 1,),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Date".tr(),
                                    style: const TextStyle(fontFamily: "Poppins",fontSize: 16,fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
                                    width: context.getWidth(divideBy: 2),
                                    child: TextField(
                                      readOnly: true,
                                      controller: bloc.dateController,
                                      onTap: () async => await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(2026)
                                      ).then((value) {
                                        if (value == null) {
                                          return;
                                        }
                                        bloc.add(HandleDateEvent(date: value.toString().split(' ').first));
                                      }),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Select Date'.tr(),
                                        prefixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedCalendar03,color:Constants.lightGreen),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16,),
                                  Text(
                                    "Type".tr(),
                                    style: const TextStyle(fontFamily: "Poppins",fontSize: 16,fontWeight: FontWeight.w500),
                                  ),
                                  BlocBuilder<CategoriesBloc,CategoriesState>(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      return ContainersTabBar(
                                        tabs: bloc.types,
                                        selectedTab: bloc.selectedType,
                                        onTap: (index) => bloc.add(ChangeTypeEvent(index: index))
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Fliter Ratings".tr(),
                                    style: const TextStyle(fontFamily: "Poppins",fontSize: 16,fontWeight: FontWeight.w500),
                                  ),
                                  BlocBuilder<CategoriesBloc,CategoriesState>(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      return ContainersTabBar(
                                        tabs: bloc.ratingsList,
                                        selectedTab: bloc.ratingType,
                                        onTap: (index) => bloc.add(ChangeRatingEvent(index: index))
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Price Range".tr(),
                                    style: const TextStyle(fontFamily: "Poppins",fontSize: 16,fontWeight: FontWeight.w500),
                                  ),
                                  BlocBuilder<CategoriesBloc,CategoriesState>(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      return RangeSlider(
                                        values: RangeValues(bloc.minPrice,bloc.maxPrice),
                                        activeColor: Constants.mainOrange,
                                        inactiveColor: Constants.lightOrange.withOpacity(.3),
                                        labels: RangeLabels(bloc.minPrice.toString(),bloc.maxPrice.toString()),
                                        divisions: 20,
                                        max: 1000,
                                        min: 0,
                                        onChanged: (range) =>bloc.add(ChangePriceEvent(range: range))
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<CategoriesBloc, CategoriesState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is ShowCategoryWorkshopsState) {
                        if (state.workshops.isEmpty) {
                          return Text("No results".tr());
                        }
                        return SingleChildScrollView(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.workshops.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                WorkshopCard(
                                  workshop: state.workshops[index],
                                  date: bloc.dateController.text,
                                  price: state.workshops[index].workshops.where((workshop) =>workshop.date == bloc.dateController.text).toList().isNotEmpty
                                    ? state.workshops[index].workshops.where((workshop) =>workshop.date == bloc.dateController.text).toList().first.price
                                    : state.workshops[index].workshops.first.price,
                                  shape: 'rect',
                                  onTap: () => context.push(screen: WorkshopDetailScreen(workshop: state.workshops[index],date: bloc.dateController.text)),
                                ),
                                const SizedBox(height: 15,)
                              ],
                            ),
                          ),
                        );
                      }
                      return Text("Wrong".tr());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}