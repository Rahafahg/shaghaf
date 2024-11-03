import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';
import 'package:shaghaf/widgets/text_fields/auth_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // key to validate form
    TextEditingController newPassword = TextEditingController();
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
              context.pushRemove(screen: const LoginScreen());
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
                                children: [
                                  AuthField(type: 'Password'.tr(), controller: newPassword),
                                  const SizedBox(height: 10),
                                  MainButton(
                                    text: 'Submit New Password',
                                    onPressed: () => bloc.add(UpdatePasswordEvent(email: email, newPassword: newPassword.text)),
                                  )
                                ],
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            )
          )
        );
      }),
    );
  }
}