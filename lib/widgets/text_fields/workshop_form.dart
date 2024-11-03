import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/workshop_group_model.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
import 'package:shaghaf/widgets/maps/organizer_map.dart';
import 'package:shaghaf/widgets/tapbar/containers_tab_bar.dart';
import 'package:shaghaf/widgets/text_fields/add_date_field.dart';
import 'package:shaghaf/widgets/text_fields/add_field.dart';
import 'package:shaghaf/widgets/text_fields/time_field.dart';

class WorkShopForm extends StatelessWidget {
  final AddWorkshopBloc bloc;
  final Workshop? workshop;
  const WorkShopForm({super.key, required this.bloc, this.workshop});

  @override
  Widget build(BuildContext context) {
    List<String> types = [
      "InSite".tr(context: context),
      "Online".tr(context: context)
    ];
    return Column(
      children: [
        AddDateField(controller: bloc.dateController, date: bloc.dateController.text),
        TimeField(timeFromController: bloc.timeFromController,timeToController: bloc.timeToController,),
        BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
          bloc: bloc,
          builder: (context, state) {
              if (state is ChangeImageState) {
                return AddField(
                  image: state.image,
                  type: 'Instructor photo'.tr(context: context),
                  onUploadImg: () async {
                    // Pick image from gallery
                    final photoAsFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (photoAsFile != null) {
                      bloc.instructorimage = File(photoAsFile.path);
                      String fileName =
                          bloc.instructorimage!.path.split('/').last;
                      log("img name: $fileName");
                      bloc.add(ChangeImageEvent(image: bloc.instructorimage));
                    } else {
                      log('No image selected');
                    }
                  },
                );
              }
              return AddField(
                image: bloc.instructorimage,
                type: 'Instructor photo'.tr(context: context),
                onUploadImg: () async {
                  // Pick image from gallery
                  final photoAsFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (photoAsFile != null) {
                    bloc.instructorimage = File(photoAsFile.path);
                    String fileName =
                        bloc.instructorimage!.path.split('/').last;
                    log("img name: $fileName");
                    bloc.add(ChangeImageEvent(image: bloc.instructorimage));
                  } else {
                    log('No image selected');
                  }
                },
              );
            }),
        AddField(
          type: 'Instructor name'.tr(context: context),
          controller: bloc.instructorNameController,
        ),
        AddField(
          type: "Instructor des".tr(context: context),
          controller: bloc.instructorDescController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddField(
              type: "Price in SR".tr(context: context),
              controller: bloc.priceController,
            ),
            const SizedBox(
              width: 5,
            ),
            AddField(
              type: "Seats".tr(context: context),
              controller: bloc.seatsController,
            ),
          ],
        ),
        SizedBox(
            width: context.getWidth(),
            child: Text("Type".tr(context: context),
                style: const TextStyle(
                  fontSize: 16,
                  color: Constants.textColor,
                ))),
        ContainersTabBar(
            tabs: types,
            selectedTab: bloc.type,
            onTap: (index) => bloc.add(ChangeTypeEvent(type: types[index]))),
        BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
          builder: (context, state) {
            if (state is SpecifyLocationState) {
              return Column(
                children: [
                  AddField(
                      type: 'Venue name'.tr(context: context),
                      controller: bloc.venueNameController),
                  AddField(
                      type: 'Venue type'.tr(context: context),
                      controller: bloc.venueTypeController),
                  SizedBox(
                      height: 150,
                      width: 350,
                      child: OrganizerMap(
                        onTap: (tapPosition, point) {
                          log("${point.latitude}, ${point.longitude}");

                          bloc.add(SpecifyLocationEvent(point: point));
                        },
                        markerPosition: state.point,
                      ))
                ],
              );
            }
            return bloc.type == "InSite".tr(context: context)
                ? Column(
                    children: [
                      AddField(
                          type: 'Venue name'.tr(context: context),
                          controller: bloc.venueNameController),
                      AddField(
                          type: 'Venue type'.tr(context: context),
                          controller: bloc.venueTypeController),
                      SizedBox(
                          height: 150,
                          width: 350,
                          child: OrganizerMap(
                            onTap: (tapPosition, point) {
                              log("${point.latitude}, ${point.longitude}");

                              bloc.add(SpecifyLocationEvent(point: point));
                            },
                          ))
                    ],
                  )
                : Column(
                    children: [
                      AddField(
                        type: "Meeting Link".tr(context: context),
                        controller: bloc.LinlUrlController,
                      ),
                    ],
                  );
          },
        )
      ],
    );
  }
}
