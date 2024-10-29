import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
import 'package:shaghaf/widgets/tapbar/containers_tab_bar.dart';
import 'package:shaghaf/widgets/text_fields/add_date_field.dart';
import 'package:shaghaf/widgets/text_fields/add_field.dart';
import 'package:shaghaf/widgets/text_fields/time_field.dart';

class WorkShopForm extends StatelessWidget {
  final AddWorkshopBloc bloc;
  const WorkShopForm({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    List<String> types = ["InSite", "Online"];
    return Column(
      children: [
        AddDateField(
            controller: bloc.dateController, date: bloc.dateController.text),
        TimeField(
          timeFromController: bloc.timeFromController,
          timeToController: bloc.timeToController,
        ),
        // map here
        BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ChangeImageState) {
                return AddField(
                  image: state.image,
                  type: 'Instructor photo',
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
                type: 'Instructor photo',
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
          type: 'Instructor name',
          controller: bloc.instructorNameController,
        ),
        AddField(
          type: 'Instructor description',
          controller: bloc.instructorDescController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddField(
              type: "Price in SR",
              controller: bloc.priceController,
            ),
            const SizedBox(
              width: 5,
            ),
            AddField(
              type: "Seats",
              controller: bloc.seatsController,
            ),
          ],
        ),
        SizedBox(
            width: context.getWidth(),
            child: const Text("type",
                style: TextStyle(
                    fontSize: 16,
                    color: Constants.textColor,
                    fontFamily: "Poppins"))),
        ContainersTabBar(
            tabs: types,
            selectedTab: bloc.type,
            onTap: (index) => bloc.add(ChangeTypeEvent(type: types[index]))),
        BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
          builder: (context, state) {
            return bloc.type == "InSite"
                ? Column(
                    children: [
                      AddField(
                          type: 'Venue name',
                          controller: bloc.venueNameController),
                      AddField(
                          type: 'Venue type',
                          controller: bloc.venueTypeController),
                    ],
                  )
                : Column(
                    children: [
                      AddField(
                        type: 'Link URL',
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
