import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/widgets/buttons/auth_text_button.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class CreateOrganizerAccountScreen extends StatelessWidget {
  const CreateOrganizerAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // key to validate form
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController licenseController = TextEditingController();
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
                          AuthField(type: 'Name',controller: nameController),
                          const SizedBox(height: 10),
                          AuthField(type: 'Email',controller: emailController),
                          const SizedBox(height: 10),
                          AuthField(type: 'Password',controller: passwordController),
                          const SizedBox(height: 10),
                          AuthField(type: 'License Number',controller: licenseController),
                          const SizedBox(height: 10),
                          const AuthField(type: 'Photo (optional)'),
                          const SizedBox(height: 20),
                          MainButton(
                            text: "Sign Up",
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
                          AuthTextButton(text: "I Already have an account", onPressed : ()=>context.pushReplacement(screen: const LoginScreen()))
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
    );
  }
}