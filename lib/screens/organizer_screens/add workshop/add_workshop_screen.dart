import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/navigation_screen/organizer_navigation.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dropdwons/category_dropdown.dart';
import 'package:shaghaf/widgets/text_fields/add_field.dart';
import 'package:shaghaf/widgets/text_fields/workshop_form.dart';

class AddWorkshopScreen extends StatelessWidget {
  const AddWorkshopScreen(
      {super.key, required this.isSingleWorkShope, this.workshop, this.isEdit=false});
  final bool isSingleWorkShope;
  final Workshop? workshop;
  final bool? isEdit;
  @override
  Widget build(BuildContext context) {
    File? workshopImage;
    return BlocProvider(
      create: (context) => AddWorkshopBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AddWorkshopBloc>();
        bloc.workshop = workshop;
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
            body: BlocConsumer<AddWorkshopBloc, AddWorkshopState>(
              listener: (context, state) {
                if (state is AddSuccessState) {
                  context.pushRemove(screen: const OrgNavigationScreen());
                }
                if (state is LoadingState) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => Center(
                          child: LottieBuilder.asset(
                              "assets/lottie/loading.json")));
                }
              },
              builder: (context, state) {
                return isSingleWorkShope == false
                    ? Stepper(
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
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                bloc.currentStep == 1
                                    ? MainButton(
                                        text: 'Create',
                                        onPressed: () {
                                          bloc.add(SubmitWorkshopEvent(
                                              isSingleWorkShope:
                                                  isSingleWorkShope,
                                              image: workshopImage!));
                                        }) // handle me later
                                    : MainButton(
                                        text: 'Next',
                                        onPressed: details.onStepContinue),
                                const SizedBox(width: 8),
                                bloc.currentStep == 0
                                    ? const SizedBox.shrink()
                                    : TextButton(
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
                                  width: context.getWidth(),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: kElevationToShadow[1],
                                      color: Constants.cardColor),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BlocBuilder<AddWorkshopBloc,
                                          AddWorkshopState>(
                                        builder: (context, state) {
                                          if (state is ChangeImageState) {
                                            return AddField(
                                                image: state.image,
                                                type: 'Add Photo',
                                                onUploadImg: () async {
                                                  // Pick image from gallery
                                                  final photoAsFile =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  if (photoAsFile != null) {
                                                    workshopImage =
                                                        File(photoAsFile.path);
                                                    String fileName =
                                                        workshopImage!.path
                                                            .split('/')
                                                            .last;
                                                    log("img name: $fileName");
                                                    bloc.add(ChangeImageEvent(
                                                        image: workshopImage));
                                                  } else {
                                                    log('No image selected');
                                                  }
                                                });
                                          }
                                          return AddField(
                                              image: workshopImage,
                                              type: 'Add Photo',
                                              onUploadImg: () async {
                                                final photoAsFile =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (photoAsFile != null) {
                                                  workshopImage =
                                                      File(photoAsFile.path);
                                                  String fileName =
                                                      workshopImage!.path
                                                          .split('/')
                                                          .last;
                                                  log("img name: $fileName");
                                                  bloc.add(ChangeImageEvent(
                                                      image: workshopImage));
                                                } else {
                                                  log('No image selected');
                                                }
                                              });
                                        },
                                      ),
                                      workshopImage != null
                                          ? const SizedBox.shrink()
                                          : const Text(
                                              "workshop image is required",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 10,
                                              )),
                                      AddField(
                                          type: 'Workshop Title',
                                          controller: bloc.titleController),
                                      AddField(
                                          type: 'Workshop Description',
                                          controller: bloc.descController),
                                      CategoryDropDown(
                                          controller: bloc.categoryController),
                                      bloc.categoryController.text == 'Category'
                                          ? const SizedBox.shrink()
                                          : const Text("Category is required",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 10,
                                              )),
                                      AddField(
                                        type: 'Audience',
                                        controller: bloc.audienceController,
                                      ),
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
                                  width: context.getWidth(),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: kElevationToShadow[1],
                                    color: Constants.cardColor,
                                  ),
                                  child: WorkShopForm(bloc: bloc),
                                )),
                          ])
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: context.getWidth(),
                                  child: const Text(
                                    "Details",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Constants.mainOrange,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  width: context.getWidth(),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: kElevationToShadow[1],
                                    color: Constants.cardColor,
                                  ),
                                  child: WorkShopForm(
                                      bloc: bloc, workshop: workshop),
                                ),
                                const SizedBox(height: 16),
                                MainButton(
                                    text: isEdit==true ? 'Submit Changes' : 'Create',
                                    onPressed: () {
                                      bloc.add(SubmitWorkshopEvent(
                                        isSingleWorkShope: isSingleWorkShope,
                                        isEdit: isEdit,
                                        workshopId: workshop?.workshopId
                                      ));
                                    })
                              ]),
                        ),
                      );
              },
            ),
          ),
        );
      }),
    );
  }
}
