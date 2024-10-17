import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/create_account_screen.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController fNameController = TextEditingController();
    TextEditingController lNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
        body: Container(
      width: context.getWidth(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/auth_bg.png'), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 61, left: 92),
              child: Image.asset('assets/images/logo.png')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              // height: context.getHeight(divideBy: 1.5),
              width: context.getWidth(),
              decoration: BoxDecoration(
                  color: const Color(0xC9D9D9D9),
                  borderRadius: BorderRadius.circular(30)),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      AuthField(
                        hint: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthField(
                        hint: 'Password',
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            log("valid");
                          } else {
                            log("invalid");
                          }
                        },
                        child: Container(
                          width: context.getWidth(),
                          height: 45,
                          decoration: BoxDecoration(
                              color: Constants.mainOrange,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(child: Text("Sign In")),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                context.pushReplacement(
                                    screen: CreateUserAccountScreen());
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Constants.mainOrange,
                                  width: 1.0, // Underline thickness
                                ))),
                                child: const Text(
                                  "Create account",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Constants.mainOrange,
                                  ),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Constants.mainOrange,
                                  width: 1.0, // Underline thickness
                                ))),
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Constants.mainOrange,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 130,
                            color: Constants.mainOrange,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "or",
                              style: TextStyle(
                                  color: Constants.mainOrange, fontSize: 13),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 130,
                            color: Constants.mainOrange,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            log("valid");
                          } else {
                            log("invalid");
                          }
                        },
                        child: Container(
                          width: context.getWidth(),
                          height: 45,
                          decoration: BoxDecoration(
                              color: Constants.mainOrange,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sign in as particepant with gmail",
                                  style: TextStyle(fontSize: 12)),
                              SizedBox(
                                width: 8,
                              ),
                              FaIcon(
                                FontAwesomeIcons.google,
                                color: Color(0xffffffff),
                              )
                            ],
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            log("valid");
                          } else {
                            log("invalid");
                          }
                        },
                        child: Container(
                          width: context.getWidth(),
                          height: 45,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                              child: Text(
                            "Continue as a guest",
                            style: TextStyle(
                                fontSize: 13, color: Constants.mainOrange),
                          )),
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
    ));
  }
}
