import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/widgets/buttons/switch_language_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/organizer_screens/profile/bloc/organizer_profile_bloc.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/cards/profile_card.dart';
import 'package:shaghaf/widgets/chapes/profile_shape.dart';
import 'package:shaghaf/widgets/text_fields/edit_org_text_field.dart';

class OrganizerProfileScreen extends StatelessWidget {
  const OrganizerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OrganizerProfileBloc>();
    final authLayer = GetIt.I.get<AuthLayer>();
    final organizer = authLayer.organizer;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(ViewOrgProfileEvent());
    });

    return GestureDetector(
      onTap: () => bloc.add(ViewOrgProfileEvent()),
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.getWidth(),
                    height: context.getHeight(divideBy: 3.5),
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 200),
                          painter: RPSCustomPainter(
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              final pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 85,
                              );
                              if (pickedFile != null) {
                                final imageFile = File(pickedFile.path);
                                bloc.add(UpdateProfileImageEvent(imageFile));
                                await authLayer
                                    .setProfileImagePath(imageFile.path);
                              }
                            },
                            child:
// Inside your BlocBuilder
                                BlocBuilder<OrganizerProfileBloc,
                                    OrganizerProfileState>(
                              builder: (context, state) {
                                ImageProvider backgroundImage;
                                final imagePath =
                                    authLayer.getProfileImagePath();

                                if (state is SuccessOrgProfileState &&
                                    state.imageFile != null) {
                                  // backgroundImage = FileImage(state.imageFile!);
                                  backgroundImage = FileImage(File(GetIt.I
                                      .get<AuthLayer>()
                                      .organizer!
                                      .image));
                                } else if (state is ErrorImageProfileState) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.msg)),
                                    );
                                  });
                                  backgroundImage = FileImage(File(GetIt.I
                                      .get<AuthLayer>()
                                      .organizer!
                                      .image));
                                } else if (state is EditingOrgProfileState) {
                                  backgroundImage = FileImage(File(GetIt.I
                                      .get<AuthLayer>()
                                      .organizer!
                                      .image));
                                } else if (state is LoadingOrgProfileState) {
                                  backgroundImage = FileImage(File(GetIt.I
                                      .get<AuthLayer>()
                                      .organizer!
                                      .image));
                                } else if (imagePath != null) {
                                  backgroundImage = FileImage(File(imagePath));
                                } else if (organizer?.image != null &&
                                    organizer!.image.isNotEmpty) {
                                  backgroundImage =
                                      NetworkImage(organizer.image);
                                } else {
                                  backgroundImage = const AssetImage(
                                      "assets/images/default_organizer_image.png");
                                }

                                return CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius:
                                      60, // Adjust this radius to resize the avatar
                                  child: ClipOval(
                                    child: Image(
                                      image: backgroundImage,
                                      width: 120, // Set desired width
                                      height: 120, // Set desired height
                                      fit: BoxFit
                                          .cover, // Ensure the image fills the avatar
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<OrganizerProfileBloc, OrganizerProfileState>(
                    builder: (context, state) {
                      if (state is LoadingOrgProfileState) {
                        return Center(
                            child: LottieBuilder.asset(
                                "assets/lottie/loading.json"));
                      }
                      if (state is SuccessOrgProfileState ||
                          state is ErrorImageProfileState) {
                        // Use the current organizer data
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  organizer?.name ?? "Organizer Name",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.textColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    bloc.add(EditOrqProfileEvent(
                                      name: organizer?.name ?? "",
                                      description: organizer?.description ?? "",
                                      contactNumber:
                                          organizer?.contactNumber ?? "",
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.mode_edit_outline_outlined,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              organizer?.description ?? "Organizer Description",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Constants.textColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 0),
                              child: ProfileCard(
                                text: organizer?.contactNumber ??
                                    "Contact Number",
                                icon: Icons.phone,
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is EditingOrgProfileState) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: [
                                  EditOrgTextField(
                                      controller: bloc.nameController),
                                  const SizedBox(height: 10),
                                  EditOrgTextField(
                                      controller: bloc.descriptionController),
                                  const SizedBox(height: 10),
                                  EditOrgTextField(
                                      controller: bloc.phoneNumberController),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            MainButton(
                              onPressed: () {
                                bloc.add(SubmitOrgProfileEvent(
                                  name: bloc.nameController.text,
                                  description: bloc.descriptionController.text,
                                  contactNumber:
                                      bloc.phoneNumberController.text,
                                ));
                              },
                              text: "Submit".tr(context: context),
                            ),
                          ],
                        );
                      }

                      return const Text(
                        "No Organizer Data Available",
                        style: TextStyle(
                          fontSize: 18,
                          color: Constants.textColor,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileCard(
                            text: organizer?.email ?? "", icon: Icons.mail),
                        const SizedBox(height: 10),
                        Text("settings".tr(context: context),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff666666),
                            )),
                        const SizedBox(height: 30),
                        const switchingLanguage(),
                        // ProfileCard(text: "Switch".tr(), icon: Icons.translate),
                        ProfileCard(
                            text: "Mode".tr(context: context),
                            icon: Icons.dark_mode),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadowColor: const Color.fromARGB(104, 222, 101, 49),
                      foregroundColor: Constants.appRedColor,
                      backgroundColor: Constants.profileColor,
                      elevation: 8,
                      fixedSize: const Size(130, 34),
                    ),
                    onPressed: () {
                      GetIt.I.get<AuthLayer>().user = null;
                      GetIt.I.get<AuthLayer>().organizer = null;
                      GetIt.I.get<AuthLayer>().box.remove('organizer');
                      context.pushRemove(screen: const LoginScreen());
                    },
                    child: Row(
                      children: [
                        const Icon(HugeIcons.strokeRoundedLogout01),
                        const SizedBox(width: 5),
                        Text("Logout".tr()),
                      ],
                    ),
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
