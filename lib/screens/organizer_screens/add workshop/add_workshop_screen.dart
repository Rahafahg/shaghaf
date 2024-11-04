import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
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
  final bool isSingleWorkShope;
  final Workshop? workshop;
  final bool? isEdit;
  const AddWorkshopScreen(
      {super.key,
      required this.isSingleWorkShope,
      this.workshop,
      this.isEdit = false});
  @override
  Widget build(BuildContext context) {
    File? workshopImage;
    final basicInfoKey = GlobalKey<FormState>();
    final detalsInfoKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => AddWorkshopBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AddWorkshopBloc>();
        bloc.workshop = workshop;
        bloc.isEdit = isEdit;
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios,
                    color: Constants.textColor),
              ),
              forceMaterialTransparency: true,
              title: Text(isEdit == false
                  ? "Add workshop".tr(context: context)
                  : "Edit workshop".tr(context: context)),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                bloc.currentStep == 1
                                    ? MainButton(
                                        text: 'Create'.tr(context: context),
                                        onPressed: () {
                                          if (detalsInfoKey.currentState!
                                                  .validate() &&
                                              bloc.instructorimage != null) {
                                            bloc.isOnline == true
                                                ? bloc.add(SubmitWorkshopEvent(
                                                    isSingleWorkShope:
                                                        isSingleWorkShope,
                                                    image: workshopImage!))
                                                : bloc.longitude != null &&
                                                        bloc.latitude != null
                                                    ? bloc.add(
                                                        SubmitWorkshopEvent(
                                                            isSingleWorkShope:
                                                                isSingleWorkShope,
                                                            image:
                                                                workshopImage!))
                                                    : ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "map required".tr(
                                                                    context:
                                                                        context))));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "field not empty".tr(
                                                            context:
                                                                context))));
                                          }
                                        }) // han
                                    : MainButton(
                                        text: 'Next'.tr(context: context),
                                        onPressed: () {
                                          if (basicInfoKey.currentState!
                                                  .validate() &&
                                              workshopImage != null &&
                                              bloc.categoryController.text
                                                  .isNotEmpty) {
                                            details.onStepContinue!();
                                          }
                                        }),
                                const SizedBox(width: 8),
                                bloc.currentStep == 0
                                    ? const SizedBox.shrink()
                                    : TextButton(
                                        onPressed: details.onStepCancel,
                                        child: Text('Back'.tr(context: context),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Constants.mainOrange,
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
                                title: Text("Basic info".tr(context: context),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Constants.mainOrange,
                                        fontWeight: FontWeight.w500)),
                                content: Container(
                                  width: context.getWidth(),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: kElevationToShadow[1],
                                      color: Constants.cardColor),
                                  child: Form(
                                    key: basicInfoKey,
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
                                                  type: 'Add Photo'
                                                      .tr(context: context),
                                                  onUploadImg: () async {
                                                    // Pick image from gallery
                                                    final photoAsFile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (photoAsFile != null) {
                                                      workshopImage = File(
                                                          photoAsFile.path);
                                                      bloc.add(ChangeImageEvent(
                                                          image:
                                                              workshopImage));
                                                    }
                                                  });
                                            }
                                            return AddField(
                                                image: workshopImage,
                                                type: 'Add Photo'
                                                    .tr(context: context),
                                                onUploadImg: () async {
                                                  final photoAsFile =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  if (photoAsFile != null) {
                                                    workshopImage =
                                                        File(photoAsFile.path);
                                                    bloc.add(ChangeImageEvent(
                                                        image: workshopImage));
                                                  }
                                                });
                                          },
                                        ),
                                        workshopImage != null
                                            ? const SizedBox.shrink()
                                            : Text(
                                                "img required"
                                                    .tr(context: context),
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                )),
                                        AddField(
                                            type: 'Workshop Title'
                                                .tr(context: context),
                                            controller: bloc.titleController),
                                        AddField(
                                            type: "Workshop Des"
                                                .tr(context: context),
                                            controller: bloc.descController),
                                        BlocBuilder<AddWorkshopBloc,
                                            AddWorkshopState>(
                                          builder: (context, state) {
                                            if (state is ChooseCategoryState ||
                                                bloc.categoryController.text
                                                    .isNotEmpty) {
                                              return CategoryDropDown(
                                                  controller:
                                                      bloc.categoryController,
                                                  onSelected: (category) {
                                                    bloc.add(
                                                        ChooseCategoryEvent(
                                                            category:
                                                                category!));
                                                    log(bloc.categoryController
                                                        .text);
                                                  });
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CategoryDropDown(
                                                    controller:
                                                        bloc.categoryController,
                                                    onSelected: (category) {
                                                      bloc.add(
                                                          ChooseCategoryEvent(
                                                              category:
                                                                  category!));
                                                      log(bloc
                                                          .categoryController
                                                          .text);
                                                    }),
                                                bloc.categoryController.text ==
                                                        "Category".tr(
                                                            context: context)
                                                    ? const SizedBox.shrink()
                                                    : Text(
                                                        "Category required".tr(
                                                            context: context),
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10,
                                                        ))
                                              ],
                                            );
                                          },
                                        ),
                                        AddField(
                                          type: 'Audience'.tr(context: context),
                                          controller: bloc.audienceController,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            //2-detail
                            Step(
                                isActive: bloc.currentStep >= 1,
                                title: Text("Details".tr(context: context),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Constants.mainOrange,
                                        fontWeight: FontWeight.w500)),
                                content: Container(
                                  width: context.getWidth(),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: kElevationToShadow[1],
                                    color: Constants.cardColor,
                                  ),
                                  child: Form(
                                      key: detalsInfoKey,
                                      child: WorkShopForm(bloc: bloc)),
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
                                  child: Text("Details".tr(context: context),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Constants.mainOrange,
                                          fontWeight: FontWeight.w500)),
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
                                  child: Form(
                                    key: detalsInfoKey,
                                    child: WorkShopForm(
                                        bloc: bloc, workshop: workshop),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                MainButton(
                                    text: isEdit == true
                                        ? 'Submit Changes'.tr(context: context)
                                        : 'Create'.tr(context: context),
                                    onPressed: () {
                                      log(isEdit.toString());
                                      if (detalsInfoKey.currentState!
                                              .validate() &&
                                          bloc.instructorimage != null &&
                                          bloc.dateController.text != "") {
                                        bloc.isOnline == true
                                            ? bloc.add(SubmitWorkshopEvent(
                                                isSingleWorkShope:
                                                    isSingleWorkShope,
                                                isEdit: isEdit))
                                            : bloc.longitude != null &&
                                                    bloc.latitude != null &&
                                                    bloc.dateController.text !=
                                                        ""
                                                ? bloc.add(SubmitWorkshopEvent(
                                                    isSingleWorkShope:
                                                        isSingleWorkShope,
                                                    isEdit: isEdit))
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "You must locate address on the map first")));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "All field must not be empty")));
                                      }
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
