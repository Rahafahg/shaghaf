import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/user_screens/home/bloc/user_home_bloc.dart';
import 'package:shaghaf/screens/user_screens/user_notification_screen.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I.get<AuthLayer>().user;
    return BlocProvider(
      create: (context) => UserHomeBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<UserHomeBloc>()..add(GetWorkshopsEvent());
          return Scaffold(
            backgroundColor: Constants.backgroundColor,
            appBar: PreferredSize(
              preferredSize:
                  Size(context.getWidth(), context.getHeight(divideBy: 13)),
              child: AppBar(
                backgroundColor: Constants.backgroundColor,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello ${user?.firstName ?? 'guest'}",
                                  style: TextStyle(
                                      fontSize: 16, color: Constants.lightOrange)),
                              Text(
                                "Welcome to Shaghaf",
                                style: TextStyle(
                                    fontSize: 16, color: Constants.mainOrange),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () =>
                            context.push(screen: const UserNotificationScreen()),
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedNotification01,
                          color: Constants.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: BlocBuilder<UserHomeBloc, UserHomeState>(
              builder: (context, state) {
                if(state is DataDoneState) {
                  return SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for a workshop ...',
                                hintStyle:
                                    TextStyle(fontSize: 12, color: Colors.black45),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Constants.lightGreen,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 12),
                              child: Text(
                                "Workshop of the week",
                                style: TextStyle(
                                    fontSize: 18, color: Constants.textColor),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/images/pasta_workshop.png",
                              fit: BoxFit.cover,
                              // width: context.getWidth(),
                              height: 200,
                            ),
                            Center(
                              child: Text(
                                "Pasta Workshop",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            const Positioned(
                              bottom: 10,
                              right: 18,
                              child: Row(
                                children: [
                                  Text(
                                    "4.6",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          shrinkWrap: true,
                          itemCount: state.workshops.length,
                          itemBuilder: (context, index) {
                            return WorkshopCard(
                              title: state.workshops[index].title,
                              subCatigory: state.workshops[index].categoryId,
                              date: "Jan 30 - Feb 2, 2024",
                              rate: "4.2",
                              img: state.workshops[index].image,
                            );
                          },
                        )
                      ]),
                    ),
                  ),
                );
                }
                return CircularProgressIndicator();
              },
            ),
          );
        }
      ),
    );
  }
}
