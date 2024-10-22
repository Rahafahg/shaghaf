import 'dart:developer';
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
import 'package:shaghaf/widgets/tapbar/tap_custom.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I.get<AuthLayer>().user;
    List<String> categories = ['All'];
    if (user != null) {
      categories.addAll(user.favoriteCategories.split(','));
    }

    log(categories.toString());
    List<Widget> categoriesWidgets =
        categories.map((category) => Text(category)).toList();
    final bloc = context.read<UserHomeBloc>();
    String? selectedCategory = "All";
    log(selectedCategory);
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
                  Text("Hello ${user?.firstName ?? 'guest'}",
                      style: const TextStyle(
                          fontSize: 16, color: Constants.lightOrange)),
                  const Text(
                    "Welcome to Shaghaf",
                    style: TextStyle(fontSize: 16, color: Constants.mainOrange),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
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

                  // body
                  return SingleChildScrollView(
                    child: Column(children: [
                      // search bar
                      SizedBox(
                        height: 40,
                        child: TextField(
                          onChanged: (value) =>
                              bloc.add(HomeSearchEvent(search: value)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Search for a workshop ...',
                            hintStyle: const TextStyle(
                                fontSize: 12, color: Colors.black45),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search,
                                color: Constants.lightGreen),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      state.workshops.isEmpty && state.search == true
                          ? Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 12),
                                    width: context.getWidth(),
                                    child: Text(
                                        "Search results for '${state.searchTerm}'",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Constants.textColor,
                                            fontFamily: "Poppins"))),
                                SizedBox(
                                    height: context.getHeight(divideBy: 2),
                                    child: const Center(
                                        child: Text("No workshops found"))),
                              ],
                            )
                          : state.workshops.isNotEmpty && state.search == true
                              // "search results"
                              ? SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 12),
                                          width: context.getWidth(),
                                          child: Text(
                                              "Search results for '${state.searchTerm}'",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Constants.textColor,
                                                  fontFamily: "Poppins"))),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: state.workshops.length,
                                        itemBuilder: (context, index) =>
                                            WorkshopCard(
                                          workshop: state.workshops[index],
                                          shape: 'rect',
                                          onTap: () => context.push(
                                              screen: WorkshopDetailScreen(
                                                  workshop:
                                                      state.workshops[index])),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 20),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    // workshop of the week
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 12),
                                        width: context.getWidth(),
                                        child: const Text(
                                            "Workshop of the week",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Constants.textColor,
                                                fontFamily: "Poppins"))),
                                    InkWell(
                                      onTap: () => context.push(
                                          screen: WorkshopDetailScreen(
                                              workshop: workshopOfTheWeek)),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: context.getWidth(),
                                            // height: 200,
                                            height:
                                                context.getHeight(divideBy: 4),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                    workshopOfTheWeek.image,
                                                    fit: BoxFit.cover,
                                                    height: 200)),
                                          ),
                                          Center(
                                            child: Text(
                                              workshopOfTheWeek.title,
                                              style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  color:
                                                      Constants.backgroundColor,
                                                  fontSize: 26),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            right: 18,
                                            child: Row(
                                              children: [
                                                Text(
                                                  workshopOfTheWeek.rating
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Constants
                                                          .backgroundColor,
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 12),
                                        width: context.getWidth(),
                                        child: const Text("Suggested For You",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Constants.textColor,
                                                fontFamily: "Poppins"))),
                                    ContainersTabBar(
                                      tabs: categories,
                                      selectedTab: selectedCategory,
                                      onTap: (index) => bloc.add(
                                          ChangeCategoryEvent(
                                              category: categories[index])),
                                    ),
                                    // suggested for you
                                    selectedCategory == "All"
                                        ? GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 20),
                                            shrinkWrap: true,
                                            itemCount: workshops.length,
                                            itemBuilder: (context, index) => WorkshopCard(
                                                onTap: () => context.push(
                                                    screen: WorkshopDetailScreen(
                                                        workshop:
                                                            workshops[index])),
                                                workshop: workshops[index]))
                                        : GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 20),
                                            shrinkWrap: true,
                                            itemCount: groupedworkshops[selectedCategory]
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) => WorkshopCard(
                                                onTap: () => context.push(screen: WorkshopDetailScreen(workshop: groupedworkshops[selectedCategory]![index])),
                                                workshop: groupedworkshops[selectedCategory]![index]))
                                  ],
                                )
                    ]),
                  );
                }
                return const Center(child: Text('something went wrong'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
