import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:shaghaf/screens/auth_screens/reset_password_screen.dart';
import 'package:shaghaf/screens/navigation_screen/organizer_navigation.dart';
import 'package:shaghaf/screens/other_screens/select_categories_screen.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? contactNumber;
  final String? name;
  final File? image;
  final String? description;
  final String? licenseNumber;
  final bool? isReset;
  const OtpScreen({super.key,required this.email,this.role,this.firstName,this.lastName,this.phoneNumber,this.contactNumber,this.description,this.image,this.licenseNumber,this.name, this.isReset=false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ErrorState) {
              context.pop();
              showDialog(context: context,builder: (context) => ErrorDialog(msg: state.msg));
            }
            if (state is LoadingState) {
              showDialog(barrierDismissible: false,context: context,builder: (context) => Center(child:LottieBuilder.asset("assets/lottie/loading.json")));
            }
            if (state is SuccessState) {
              if(isReset == true) {
                log('yes it is reset');
                context.pushRemove(screen: ResetPasswordScreen(email: email));
                return;
              }
              GetIt.I.get<SupabaseLayer>().getAllCategories();
              context.pushRemove(screen: role == 'user' ? const SelectCategoriesScreen() : const OrgNavigationScreen());
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: SingleChildScrollView(
              child: Container(
                width: context.getWidth(),
                height: context.getHeight(),
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth_bg.png'),fit: BoxFit.cover)),
                child: Column(
                  children: [
                    // logo
                    Container(padding: const EdgeInsets.only(top: 61, left: 92),child: Image.asset('assets/images/logo.png')),
                    const SizedBox(height: 116,),
                    // otp
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 31),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 17),
                        width: context.getWidth(),
                        decoration: BoxDecoration(color: const Color(0xC9D9D9D9),borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const Text(
                              "Confirm your Email",
                              style: TextStyle(
                                fontSize: 18,
                                color: Constants.mainOrange,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                              )
                            ),
                            const SizedBox(height: 7,),
                            Text(
                              "We have sent to : $email\na one-time-password (OTP) to confirm your email",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12,color: Color(0xff666666),fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12,),
                            Pinput(
                              length: 6,
                              keyboardType: TextInputType.number,
                              onCompleted: (value) =>
                              role == null ? bloc.add(VerifyOtpEvent(email: email, otp:value)) :
                              role == "user"
                              ? bloc.add(VerifyOtpEvent(email: email,firstName: firstName!,lastName: lastName!,otp: value,phoneNumber: phoneNumber!))
                              : bloc.add(VerifyOrganizerOtpEvent(email: email,otp: value,contactNumber: contactNumber!,description: description!,image: image,licenseNumber: licenseNumber!,name: name!)),
                                defaultPinTheme: const PinTheme(
                                  textStyle: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(color: Colors.white70,borderRadius: BorderRadius.all(Radius.circular(5)))
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Didn’t receive code ? ",
                                    style: TextStyle(color: Color(0xff666666),fontFamily: "Poppins",fontSize: 12),
                                  ),
                                  OtpTimerButton(
                                    onPressed: () => log("handle me"),
                                    text: const Text("Re-send",style: TextStyle(fontFamily: "Poppins",color: Constants.mainOrange,fontSize: 12)),
                                    duration: 60,
                                    buttonType: ButtonType.text_button,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ),
        );
      }),
    );
  }
}