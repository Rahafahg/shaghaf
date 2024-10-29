import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/auth_screens/otp_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class CreateUserAccountScreen extends StatelessWidget {
  const CreateUserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // key to validate form
    TextEditingController fNameController = TextEditingController();
    TextEditingController lNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ErrorState) {
              context.pop();
              showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(msg: state.msg));
            }
            if (state is LoadingState) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Center(
                      child: LottieBuilder.asset("assets/lottie/loading.json"))
                  );
            }
            if (state is SuccessState) {
              context.pop();
              context.pushReplacement(
                  screen: OtpScreen(
                      email: emailController.text,
                      role: 'user',
                      firstName: fNameController.text,
                      lastName: lNameController.text,
                      phoneNumber: phoneNumberController.text));
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                body: SingleChildScrollView(
              child: Container(
                width: context.getWidth(),
                height: context.getHeight(),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/auth_bg.png'),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // logo
                      Container(
                          padding: const EdgeInsets.only(top: 61, left: 92),
                          child: Image.asset('assets/images/logo.png')),
                      // form
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: Container(
                          width: context.getWidth(),
                          decoration: BoxDecoration(
                              color: const Color(0xC9D9D9D9),
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AuthField(
                                      type: 'First Name',
                                      controller: fNameController),
                                  const SizedBox(height: 10),
                                  AuthField(
                                      type: 'Last Name',
                                      controller: lNameController),
                                  const SizedBox(height: 10),
                                  AuthField(
                                      type: 'Email',
                                      controller: emailController),
                                  const SizedBox(height: 10),
                                  AuthField(
                                      type: 'Password',
                                      controller: passwordController),
                                  const SizedBox(height: 10),
                                  AuthField(
                                      type: 'Phone Number',
                                      controller: phoneNumberController),
                                  const SizedBox(height: 20),
                                  MainButton(
                                    text: "Sign Up",
                                    width: context.getWidth(),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        bloc.add(CreateAccountEvent(
                                            email: emailController.text,
                                            password: passwordController.text));
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 4),
                                  InkWell(
                                      onTap: () => context.pushReplacement(
                                          screen: const LoginScreen()),
                                      child: SizedBox(
                                          width: context.getWidth(),
                                          child: const Text(
                                              "I Already have an account",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: "Poppins",
                                                color: Constants.mainOrange,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    Constants.mainOrange,
                                              ))))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        );
      }),
    );
  }
}
