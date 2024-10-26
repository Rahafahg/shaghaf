import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dropdwons/category_dropdown.dart';
import 'package:shaghaf/widgets/text_fields/add_date_field.dart';
import 'package:shaghaf/widgets/text_fields/add_field.dart';
import 'package:shaghaf/widgets/text_fields/time_field.dart';

class AddWorkshopScreen extends StatelessWidget {
  const AddWorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // File? image;
    return BlocProvider(
      create: (context) => AddWorkshopBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AddWorkshopBloc>();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Constants.backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios,
                    color: Constants.textColor),
              ),
              forceMaterialTransparency: true,
              title: const Text("Add workshop"),
              centerTitle: true,
            ),
            body: BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
              builder: (context, state) {
                return Stepper(
                    onStepContinue: () => bloc.add(StepContinueEvent()),
                    onStepCancel: () => bloc.add(StepCancelEvent()),
                    currentStep: bloc.currentStep,
                    connectorColor:
                        WidgetStateProperty.all(Constants.mainOrange),
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            bloc.currentStep == 1
                                ? MainButton(
                                    text: 'Create',
                                    onPressed: () => log("You are donnee"),
                                  )
                                : MainButton(
                                    text: 'Next',
                                    onPressed: details.onStepContinue,
                                  ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: details.onStepCancel,
                              child: const Text('Back',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Constants.mainOrange,
                                    fontFamily: "Poppins",
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                    steps: [
                      //1-basic information
                      Step(
                          isActive: bloc.currentStep >= 0,
                          title: const Text("Basic information",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Constants.mainOrange,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500)),
                          content: Container(
                            // height: 600,
                            width: context.getWidth(),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: kElevationToShadow[1],
                                color: Constants.cardColor),
                            child: Column(
                              children: [
                                BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
                                  builder: (context, state) {
                                    if (state is ChangeImageState) {
                                      return AddField(
                                          image: state.image,
                                          type: 'Add Photo',
                                          onUploadImg: () async {
                                            print(
                                                "---------------------------aaaaaaa333333");
                                            // Pick image from gallery
                                            final photoAsFile =
                                                await ImagePicker().pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (photoAsFile != null) {
                                              bloc.image =
                                                  File(photoAsFile.path);
                                              String fileName = bloc.image!.path
                                                  .split('/')
                                                  .last;
                                              log("img name: $fileName");
                                              bloc.add(ChangeImageEvent());
                                            } else {
                                              log('No image selected');
                                            }
                                          });
                                    }
                                    return AddField(
                                        image: bloc.image,
                                        type: 'Add Photo',
                                        onUploadImg: () async {
                                          print(
                                              "---------------------------aaaaaaa3333334444444444444");
                                          // Pick image from gallery
                                          final photoAsFile =
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.gallery);
                                          if (photoAsFile != null) {
                                            bloc.image = File(photoAsFile.path);
                                            String fileName = bloc.image!.path
                                                .split('/')
                                                .last;
                                            log("img name: $fileName");
                                            bloc.add(ChangeImageEvent());
                                          } else {
                                            log('No image selected');
                                          }
                                        });
                                  },
                                ),
                                const AddField(type: 'Workshop Title'),
                                const AddField(type: 'Workshop Description'),
                                const CategoryDropDown(),
                                AddField(type: 'Audience'),
                              ],
                            ),
                          )),
                      //2-detail
                      Step(
                          isActive: bloc.currentStep >= 1,
                          title: const Text(
                            "Details",
                            style: TextStyle(
                                fontSize: 18,
                                color: Constants.mainOrange,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                          content: Container(
                            // height:
                            //     600, // Ensure the container has a fixed height
                            width: context.getWidth(),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: kElevationToShadow[1],
                              color: Constants.cardColor,
                            ),
                            child: Column(
                              children: [
                                AddField(type: 'Instructor photo'),
                                AddField(type: 'Instructor description'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AddField(type: "Price"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    AddField(type: "Seats"),
                                  ],
                                ),
                                AddField(type: 'Venue name'),
                                AddField(type: 'Venue type'),
                                // Expanded(
                                //   // Wrap the DefaultTabController in Expanded to ensure it fits inside the Column
                                //   child: DefaultTabController(
                                //     length: 2,
                                //     child: Column(
                                //       children: [
                                // TabBar(
                                //   isScrollable: false,
                                //   unselectedLabelStyle: TextStyle(
                                //     color: Constants.appGreyColor,
                                //   ),
                                //   labelStyle: TextStyle(
                                //     color: Constants.mainOrange,
                                //   ),
                                //   indicatorSize:
                                //       TabBarIndicatorSize.tab,
                                //   indicatorColor: Constants.mainOrange,
                                //   dividerColor: Constants.appGreyColor,
                                //   tabs: const [
                                //     Tab(text: "In site"),
                                //     Tab(text: "Online"),
                                //   ],
                                // ),
                                // Expanded(
                                //   // Wrap TabBarView in Expanded to take available space
                                //   child: TabBarView(
                                //     children: [
                                //       Column(
                                //         children: [
                                //           const SizedBox(height: 10),
                                //           AddDateField(),
                                //           AddField(type: 'Venue name'),
                                //           AddField(type: 'Venue type'),
                                //           Expanded(
                                //             // Use Expanded only here, as the parent column now has constrained height
                                //             child: TimeField(),
                                //           ),
                                //         ],
                                //       ),
                                //       Center(
                                //         child: AddField(
                                //             type: 'meeting_url'),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )),
                    ]);
              },
            ),
          ),
        );
      }),
    );
  }
}
