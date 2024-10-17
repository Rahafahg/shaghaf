import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class CreateUserAccountScreen extends StatelessWidget {
  const CreateUserAccountScreen({super.key});

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
                        hint: 'First Name',
                        controller: fNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthField(
                        hint: 'Last Name',
                        controller: lNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                        height: 10,
                      ),
                      AuthField(
                        hint: 'Phone Number',
                        controller: phoneNumberController,
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
                          child: const Center(child: Text("Sign Up")),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                context.pushReplacement(screen: const LoginScreen());
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Constants.mainOrange,
                                  width: 1.0, // Underline thickness
                                ))),
                                child: const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Constants.mainOrange,
                                  ),
                                ),
                              ))
                        ],
                      )
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

// class CreateUserAccountScreen extends StatelessWidget {
//   const CreateUserAccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     TextEditingController fNameController = TextEditingController();
//     TextEditingController lNameController = TextEditingController();
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     TextEditingController phoneNumberController = TextEditingController();

//     return Scaffold(
//       body: Expanded(
//         child: Stack(
//           children: [
//             // Background image that fills the entire screen
//             Positioned.fill(
//               child: Image.asset(
//                 'assets/images/auth_bg.png',
//                 fit: BoxFit.cover, // Ensures the image covers the entire background
//               ),
//             ),
//             // Scrollable content
//             SingleChildScrollView(
//               child: Container(
//                 width: context.getWidth(),
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 50), // Add some space from the top to avoid content overlapping
//                     // Logo
//                     Container(
//                       padding: const EdgeInsets.only(left: 92),
//                       child: Image.asset('assets/images/logo.png'),
//                     ),
//                     const SizedBox(height: 20),
//                     // Form container
//                     Container(
//                       width: context.getWidth(),
//                       decoration: BoxDecoration(
//                         color: const Color(0xC9D9D9D9),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Form(
//                         key: formKey,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               AuthField(
//                                 hint: 'First Name',
//                                 controller: fNameController,
//                               ),
//                               const SizedBox(height: 10),
//                               AuthField(
//                                 hint: 'Last Name',
//                                 controller: lNameController,
//                               ),
//                               const SizedBox(height: 10),
//                               AuthField(
//                                 hint: 'Email',
//                                 controller: emailController,
//                               ),
//                               const SizedBox(height: 10),
//                               AuthField(
//                                 hint: 'Password',
//                                 controller: passwordController,
//                               ),
//                               const SizedBox(height: 10),
//                               AuthField(
//                                 hint: 'Phone Number',
//                                 controller: phoneNumberController,
//                               ),
//                               const SizedBox(height: 20),
//                               GestureDetector(
//                                 onTap: () {
//                                   if (formKey.currentState!.validate()) {
//                                     log("valid");
//                                   } else {
//                                     log("invalid");
//                                   }
//                                 },
//                                 child: Container(
//                                   width: context.getWidth(),
//                                   height: 45,
//                                   decoration: BoxDecoration(
//                                     color: Constants.mainOrange,
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   child: const Center(child: Text("Sign Up")),
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: Constants.mainOrange,
//                                             width: 1.0, // Underline thickness
//                                           ),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         "Already have an account?",
//                                         style: TextStyle(
//                                           fontSize: 11,
//                                           color: Constants.mainOrange,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               // const SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CreateOrganizerAccountScreen extends StatelessWidget {
  const CreateOrganizerAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
