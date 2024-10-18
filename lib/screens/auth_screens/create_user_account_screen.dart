import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/screens/auth_screens/otp_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class CreateUserAccountScreen extends StatelessWidget {
  const CreateUserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // key to validate form
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is ErrorState) {
              log('error happened');
            }
            if(state is LoadingState) {
              log('i am loading');
            }
            if(state is SuccessState) {
              log('nice, check email');
              context.pushReplacement(screen: OtpScreen(email: bloc.emailController.text, firstName: bloc.fNameController.text,lastName: bloc.lNameController.text,));
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
                                    controller: bloc.fNameController),
                                const SizedBox(height: 10),
                                AuthField(
                                    type: 'Last Name',
                                    controller: bloc.lNameController),
                                const SizedBox(height: 10),
                                AuthField(
                                    type: 'Email', controller: bloc.emailController),
                                const SizedBox(height: 10),
                                AuthField(
                                    type: 'Password',
                                    controller: bloc.passwordController),
                                const SizedBox(height: 10),
                                AuthField(
                                    type: 'Phone Number',
                                    controller: bloc.phoneNumberController),
                                const SizedBox(height: 20),
                                MainButton(
                                  text: "Sign Up",
                                  width: context.getWidth(),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(CreateAccountEvent(
                                        email: bloc.emailController.text,
                                        password: bloc.passwordController.text
                                      ));
                                    }
                                  },
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                    onTap: () => context.pushReplacement(
                                        screen: const LoginScreen()),
                                    child: SizedBox(
                                        width: context.getWidth(),
                                        child: Text("I Already have an account",
                                            textAlign: TextAlign.end,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Constants.mainOrange,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Constants.mainOrange,
                                                    fontSize: 11))))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      }),
    );
  }
}