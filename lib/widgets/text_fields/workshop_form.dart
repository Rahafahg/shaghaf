import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaghaf/screens/organizer_screens/add%20workshop/bloc/add_workshop_bloc.dart';
import 'package:shaghaf/widgets/text_fields/add_date_field.dart';
import 'package:shaghaf/widgets/text_fields/add_field.dart';
import 'package:shaghaf/widgets/text_fields/time_field.dart';

class WorkShopForm extends StatelessWidget {
  const WorkShopForm({
    super.key,
     this.bloc, 
    //required this.date, required this.index
  });
  // final String date;
  final dynamic bloc;
  // final String index;
  @override
  Widget build(BuildContext context) {
    File? instructorimage;
    final TextEditingController timeFromController = TextEditingController();
    final TextEditingController timeToController = TextEditingController();
    final TextEditingController instructorNameController =
        TextEditingController();
    final TextEditingController instructorDescController =
        TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController seatsController = TextEditingController();
    final TextEditingController venueNameController = TextEditingController();
    final TextEditingController venueTypeController = TextEditingController();

    return Column(
      children: [
        AddDateField(
          // date: DateTime.now().toString(),
            date: '',

        ),
        TimeField(
          timeFromController: timeFromController,
          timeToController: timeToController,
        ),
        BlocBuilder<AddWorkshopBloc, AddWorkshopState>(
            builder: (context, state) {
          if (state is ChangeImageState) {
            return AddField(
              image: state.image,
              type: 'Instructor photo',
              onUploadImg: () async {
                // Pick image from gallery
                final photoAsFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (photoAsFile != null) {
                  instructorimage = File(photoAsFile.path);
                  String fileName = instructorimage!.path.split('/').last;
                  log("img name: $fileName");
                  bloc.add(ChangeImageEvent(image: instructorimage));
                } else {
                  log('No image selected');
                }
              },
            );
          }
          return AddField(
            image: instructorimage,
            type: 'Instructor photo',
            onUploadImg: () async {
              // Pick image from gallery
              final photoAsFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (photoAsFile != null) {
                instructorimage = File(photoAsFile.path);
                String fileName = instructorimage!.path.split('/').last;
                log("img name: $fileName");
                bloc.add(ChangeImageEvent(image: instructorimage));
              } else {
                log('No image selected');
              }
            },
          );
        }),
        AddField(
          type: 'Instructor name',
          controller: instructorNameController,
          onSaved: (value) {
            instructorNameController.text = value ?? ' ';
            bloc.addItem(
                key: 'Instructor name', item: instructorNameController.text);
          },
        ),
        AddField(
          type: 'Instructor description',
          controller: instructorDescController,
          onSaved: (value) {
            instructorDescController.text = value ?? ' ';
            bloc.addItem(
                key: 'Instructor description',
                item: instructorDescController.text);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddField(
              type: "Price",
              controller: priceController,
              onSaved: (value) {
                priceController.text = value ?? ' ';
                bloc.addItem(
                    key: 'Instructor description', item: priceController.text);
              },
            ),
            const SizedBox(
              width: 5,
            ),
            AddField(
              type: "Seats",
              controller: seatsController,
            ),
          ],
        ),
        AddField(type: 'Venue name', controller: venueNameController),
        AddField(type: 'Venue type', controller: venueTypeController),
      ],
    );
  }
}
