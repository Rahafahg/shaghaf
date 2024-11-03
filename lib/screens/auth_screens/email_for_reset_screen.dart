import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:shaghaf/screens/auth_screens/otp_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class EmailForResetScreen extends StatelessWidget {
  const EmailForResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // key to validate form
    TextEditingController emailResetController = TextEditingController();
    return BlocProvider(
      create: (context)=> AuthBloc(),
      child: Builder(builder: (context){
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
              context.pop();
              context.pushRemove(screen: OtpScreen(email: emailResetController.text, isReset: true));
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
                      Container(margin: const EdgeInsets.only(bottom: 100),padding: const EdgeInsets.only(top: 61, left: 92),child: Image.asset('assets/images/logo.png')),
                      // form
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: Container(
                          width: context.getWidth(),
                          height: context.getHeight(divideBy: 4),
                          decoration: BoxDecoration(color: const Color(0xC9D9D9D9),borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  AuthField(type: 'Email'.tr(), controller: emailResetController),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(onPressed: ()=>context.pop(), child: Text("Back".tr(), style: const TextStyle(color: Constants.mainOrange, fontFamily: "Poppins"))),
                                      MainButton(
                                        text: 'Send OTP'.tr(),
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            bloc.add(RequestResetPasswordEvent(email: emailResetController.text));
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}