import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/user_screens/profile/bloc/profile_bloc.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/buttons/switch_language_button.dart';
import 'package:shaghaf/widgets/buttons/switch_mood_button.dart';
import 'package:shaghaf/widgets/cards/profile_card.dart';
import 'package:shaghaf/widgets/chapes/profile_shape.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I.get<AuthLayer>().user;
    final bloc = context.read<UserProfileBloc>();
    return GestureDetector(
      onTap: () => bloc.add(ViewUserProfileEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: context.getWidth(),
                height: context.getHeight(divideBy: 3.5),
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(context.getWidth(), 200),
                      painter: RPSCustomPainter(width: context.getWidth(), context: context),
                    ),
                  ],
                ),
              ),
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is LoadingProfileState) {
                    return Center(child:LottieBuilder.asset("assets/lottie/loading.json"));
                  }
                  if (state is SuccessProfileState) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user == null ? "Hello, Guest" : "${user.firstName} ${user.lastName}",
                              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onSecondary,fontFamily: "Poppins",),
                            ),
                            user == null ? const SizedBox.shrink()
                            : IconButton(
                              onPressed: ()=>bloc.add(EditUserProfileEvent(firstName: user.firstName,lastName: user.lastName,phoneNumber: user.phoneNumber)),
                              icon: Icon(Icons.mode_edit_outline_outlined,size: 30,color: Theme.of(context).primaryColor)
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                          child: ProfileCard(text: user?.phoneNumber ?? "", icon: Icons.phone),
                        ),
                      ],
                    );
                  }
                  if (state is EditingProfileState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              EditTextField(controller: bloc.firstNameController),
                              const SizedBox(width: 10), // Space between fields
                              EditTextField(controller: bloc.lastNameController),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 8,
                                          color:
                                              Color.fromARGB(104, 222, 101, 49),
                                          spreadRadius: 0)
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                    child: const Icon(
                                      Icons.phone,
                                      color: Constants.mainOrange,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                EditTextField(
                                    controller: bloc.phoneNumberController),
                                const SizedBox(width: 15),
                                MainButton(
                                  onPressed: () {
                                    bloc.add(SubmitUserProfileEvent(
                                        firstName:
                                            bloc.firstNameController.text,
                                        lastName: bloc.lastNameController.text,
                                        phoneNumber:
                                            bloc.phoneNumberController.text));
                                  },
                                  text: "Submit".tr(context: context),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user == null
                                ? "Hello, Guest"
                                : "${user.firstName} ${user.lastName}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSecondary,

                              // color: Constants.textColor,
                            ),
                          ),
                          user == null
                              ? const SizedBox.shrink()
                              : IconButton(
                                  onPressed: () {
                                    bloc.add(EditUserProfileEvent(
                                        firstName: user.firstName,
                                        lastName: user.lastName,
                                        phoneNumber: user.phoneNumber));
                                  },
                                  icon: Icon(Icons.mode_edit_outline_outlined,
                                      size: 30,
                                      color: Theme.of(context).primaryColor))
                        ],
                      ),
                      const SizedBox(height: 10),
                      user == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 0),
                              child: ProfileCard(
                                  text: user.phoneNumber, icon: Icons.phone),
                            ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user == null
                        ? const SizedBox.shrink()
                        : ProfileCard(text: user.email, icon: Icons.mail),
                    const SizedBox(height: 10),
                    // Text("settings").tr(),
                    Text("settings".tr(context: context),
                        style: TextStyle(
                            fontSize: 18,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color)),
                    const SizedBox(height: 30),
                    const SwitchingLanguage(),
                    const SwitchMoodButton()
                  ],
                ),
              ),
              const SizedBox(height: 20),
              user == null
                  ? MainButton(
                      text: 'Login'.tr(),
                      onPressed: () =>
                          context.pushRemove(screen: const LoginScreen()),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          shadowColor: const Color.fromARGB(104, 222, 101, 49),
                          foregroundColor: Constants.appRedColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          elevation: 8,
                          fixedSize: const Size(130, 34)),
                      onPressed: () {
                        GetIt.I.get<AuthLayer>().user = null;
                        GetIt.I.get<AuthLayer>().box.remove('user');
                        GetIt.I.get<AuthLayer>().box.remove('notifications');
                        GetIt.I.get<AuthLayer>().box.remove('organizer');
                        context.pushRemove(screen: const LoginScreen());
                      },
                      child: Row(
                        children: [
                          const Icon(HugeIcons.strokeRoundedLogout01),
                          const SizedBox(width: 5),
                          Text("Logout".tr()),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "First Name",
          border: OutlineInputBorder(
            // Default border
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey, // Default border color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            // Border when the field is not focused
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey, // Border color for enabled state
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // Border when the field is focused
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Constants.mainOrange,
              // Border color for focused state
              width: 2, // Border width when focused
            ),
          ),
        ),
      ),
    );
  }
}
