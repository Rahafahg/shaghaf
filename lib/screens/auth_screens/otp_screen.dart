import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:shaghaf/screens/other_screens/select_categories_screen.dart';
import 'package:shaghaf/widgets/dialogs/error_dialog.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  const OtpScreen({super.key, required this.email, required this.firstName, required this.lastName, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is ErrorState) {
              context.pop();
              showDialog(context: context, builder: (context)=>ErrorDialog(msg: state.msg));
            }
            if(state is LoadingState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Center(child: CircularProgressIndicator(color: Constants.mainOrange))
              );
            }
            if(state is SuccessState) {
              context.pushRemove(screen: const SelectCategories());
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
                              Text("Confirm your Email", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Constants.mainOrange),),
                              const SizedBox(height: 7,),
                              const Text("We have sent you a one-time-password (OTP) to confirm your email", textAlign: TextAlign.center,style: TextStyle(fontSize: 12, color: Color(0xff666666), fontWeight: FontWeight.w500),),
                              const SizedBox(height: 12,),
                              Pinput(
                                length: 6,
                                keyboardType: TextInputType.number,
                                onCompleted: (value) => bloc.add(VerifyOtpEvent(
                                  email: email,
                                  firstName: firstName,
                                  lastName: lastName,
                                  otp: value,
                                  phoneNumber: phoneNumber
                                )),
                                defaultPinTheme: PinTheme(
                                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
                                  height: 45,
                                  width: 45,
                                  decoration: const BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.all(Radius.circular(5)))
                                ),
                              )
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