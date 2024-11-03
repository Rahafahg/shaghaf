import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/user_screens/home/bloc/user_home_bloc.dart';
import 'package:shaghaf/screens/user_screens/other/user_notification_screen.dart';
import 'package:shaghaf/screens/user_screens/other/workshop_detail_screen.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';
import 'package:shaghaf/widgets/tapbar/containers_tab_bar.dart';
import 'package:shaghaf/widgets/text_fields/search_field.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I.get<AuthLayer>().user;

    List<String> categories = ['All'];
    if (user != null) {
      categories.addAll(user.favoriteCategories.split(','));
    }

    print(categories.toString());
    List<Widget> categoriesWidgets =
        categories.map((category) => Text(category)).toList();
    final bloc = context.read<UserHomeBloc>();
    String? selectedCategory = "All";
    print(selectedCategory);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        // app bar
        appBar: PreferredSize(
          preferredSize:
              Size(context.getWidth(), context.getHeight(divideBy: 13)),
          child: Padding(
            padding: const EdgeInsets.only(top: 11, right: 16, left: 16),
            child: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Constants.backgroundColor,
              actions: [
                IconButton(
                  onPressed: () =>
                      context.push(screen: const UserNotificationScreen()),
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification01,
                    color: Constants.lightGreen,
                  ),
                ),
              ],
              leadingWidth: context.getWidth(),
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Hello",
                              style: TextStyle(
                                  fontSize: 16, color: Constants.lightOrange))
                          .tr(context: context),
                      const SizedBox(width: 5),
                      Text(user?.firstName ?? 'guest',
                          style: const TextStyle(
                              fontSize: 16, color: Constants.lightOrange))
                    ],
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 16, color: Constants.mainOrange),
                  ).tr(context: context),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<UserHomeBloc, UserHomeState>(
            builder: (context, state) {
              if (state is ErrorWorkshopsState) {
                return Center(
                    child: Text(state.msg,
                        style: const TextStyle(
                            fontFamily: "Poppins", fontSize: 20)));
              }
              if (state is LoadingWorkshopsState) {
                return Center(
                    child: LottieBuilder.asset("assets/lottie/loading.json"));
              }
              if (state is SuccessWorkshopsState) {
                final workshops = GetIt.I.get<DataLayer>().workshops;
                final groupedworkshops = groupworkshopsByCategory(workshops);
                WorkshopGroupModel workshopOfTheWeek =
                    GetIt.I.get<DataLayer>().workshopOfTheWeek ??
                        workshops.first;
                selectedCategory = state.selectedCategory ?? "All";
                var fraction =
                    (workshopOfTheWeek.rating % 1 * pow(10, 2)).floor();
                String rating =
                    "${workshopOfTheWeek.rating.toString().split(".")[0]}.$fraction";
                // body
                return SingleChildScrollView(
                    child: Column(children: [
                  // search bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12, 16, 0),
                    child: SizedBox(
                        height: 40,
                        child: SearchField(
                            onChanged: (value) =>
                                bloc.add(HomeSearchEvent(search: value)))),
                  ),
                  state.workshops.isEmpty && state.search == true
                      ? Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(16),
                                width: context.getWidth(),
                                child: Row(
                                  children: [
                                    Text("Search results".tr(context: context),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Constants.textColor,
                                        )),
                                    Text('${state.searchTerm}',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Constants.textColor,
                                        ))
                                  ],
                                )),
                            SizedBox(
                                height: context.getHeight(divideBy: 2),
                                child: Center(
                                    child: Text(
                                        "No results".tr(context: context)))),
                          ],
                        )
                      : state.workshops.isNotEmpty && state.search == true
                          // "search results"
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(16),
                                      width: context.getWidth(),
                                      child: Row(
                                        children: [
                                          Text(
                                              "Search results"
                                                  .tr(context: context),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Constants.textColor,
                                              )),
                                          Text('${state.searchTerm}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Constants.textColor,
                                              ))
                                        ],
                                      )),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: state.workshops.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: WorkshopCard(
                                        workshop: state.workshops[index],
                                        shape: 'rect',
                                        onTap: () => context.push(
                                            screen: WorkshopDetailScreen(
                                                workshop:
                                                    state.workshops[index])),
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                  )
                                ],
                              ),
                            )
                          : Column(children: [
                              // workshop of the week
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 12),
                                    width: context.getWidth(),
                                    child: Text(
                                        "week Workshop".tr(context: context),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Constants.textColor,
                                        ))),
                              ),
                              InkWell(
                                onTap: () => context.push(
                                    screen: WorkshopDetailScreen(
                                        workshop: workshopOfTheWeek)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: context.getWidth(),
                                        // height: 200,
                                        height: context.getHeight(divideBy: 4),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                              height: context.getHeight(),
                                              width: context.getWidth(),
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.35),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        workshopOfTheWeek
                                                            .image),
                                                    fit: BoxFit.cover,
                                                  )),
                                              child: Container(
                                                height: context.getHeight(),
                                                width: context.getWidth(),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.black
                                                        .withOpacity(0.25)),
                                                child: Text(
                                                    workshopOfTheWeek.title,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontFamily: "Poppins")),
                                              )),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 18,
                                        child: Row(
                                          children: [
                                            Text(
                                              rating.toString(),
                                              style: const TextStyle(
                                                  color:
                                                      Constants.backgroundColor,
                                                  fontSize: 16),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  width: context.getWidth(),
                                  child: Text("Suggested".tr(context: context),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Constants.textColor,
                                      ))),
                              user == null
                                  ? const SizedBox.shrink()
                                  : ContainersTabBar(
                                      tabs: categories,
                                      selectedTab: selectedCategory,
                                      onTap: (index) => bloc.add(
                                          ChangeCategoryEvent(
                                              category: categories[index])),
                                    ),
                              // suggested for you
                              selectedCategory == "All"
                                  ? GridView.builder(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 5, 16, 16),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                              childAspectRatio: 0.91),
                                      // Vertical spacing between cards

                                      shrinkWrap: true,
                                      itemCount: workshops.length,
                                      itemBuilder: (context, index) => WorkshopCard(
                                          onTap: () => context.push(
                                              screen: WorkshopDetailScreen(
                                                  workshop: workshops[index])),
                                          workshop: workshops[index]))
                                  : GridView.builder(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 5, 16, 16),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                              childAspectRatio: 0.91),
                                      shrinkWrap: true,
                                      itemCount: groupedworkshops[selectedCategory]?.length ??
                                          0,
                                      itemBuilder: (context, index) => WorkshopCard(
                                          onTap: () => context.push(
                                              screen: WorkshopDetailScreen(workshop: groupedworkshops[selectedCategory]![index])),
                                          workshop: groupedworkshops[selectedCategory]![index])),
                            ])
                ]));
              }
              return const Center(child: Text('something went wrong'));
            },
          ),
        ),
      ),
    );
  }
}
