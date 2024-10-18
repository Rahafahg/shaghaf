import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/other_screens/select_role_screen.dart';
import 'package:shaghaf/widgets/buttons/auth_text_button.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // key to validate form
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: context.getWidth(),
            height: context.getHeight(),
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth_bg.png'), fit: BoxFit.cover)),
            child: Column(
              children: [
                // logo
                Container(padding: const EdgeInsets.only(top: 61, left: 92),child: Image.asset('assets/images/logo.png')),
                // form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Container(
                    width: context.getWidth(),
                    decoration: BoxDecoration(color: const Color(0xC9D9D9D9),borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            AuthField(type: 'Email',controller: emailController),
                            const SizedBox(height: 10),
                            AuthField(type: 'Password',controller: passwordController),
                            const SizedBox(height: 20),
                            MainButton(
                              text: "Sign In",
                              width: context.getWidth(),
                              onPressed: () {
                                if(formKey.currentState!.validate()) {
                                  log("valid");
                                }
                                else {
                                  log("invalid");
                                }
                              },
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AuthTextButton(text: "Create Account", onPressed: () => context.pushReplacement(screen: const SelectRoleScreen()),),
                                AuthTextButton(text: "Forgot Password ?", onPressed: () => log("handle me later !!"),)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(height: 1,width: 100,color: Constants.mainOrange),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("or",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Constants.mainOrange)),
                                ),
                                Container(height: 1,width: 100,color: Constants.mainOrange),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // MainButton(text: "Sign in as particepant with gmail", fontSize: 12,),
                            GestureDetector(
                              onTap: () => log("handle me later !!"),
                              child: Container(
                                width: context.getWidth(),
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Constants.mainOrange,
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Center(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Sign in as particepant with gmail",style: TextStyle(fontSize: 12)),
                                    SizedBox(width: 8),
                                    FaIcon(FontAwesomeIcons.google,color: Color(0xffffffff))
                                  ],
                                )
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: ()=>log("No validation required, im a guest !!"),
                            child: Container(
                              width: context.getWidth(),
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(25)
                              ),
                              child: const Center(
                                child: Text("Continue as a guest",style: TextStyle(fontSize: 13, color: Constants.mainOrange))
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ),
    );
  }
}