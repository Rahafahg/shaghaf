import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/widgets/cards/role_card.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GetIt.I.get<AuthLayer>().onboardingShown();
    return Scaffold(
      body: Container(
        width: context.getWidth(),
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth_bg.png'), fit: BoxFit.cover),),
        child: Column(
          children: [
            Container(padding: const EdgeInsets.only(top: 61, left: 92),child: Image.asset('assets/images/logo.png')),
            const SizedBox(height: 55,),
            Row(mainAxisAlignment: MainAxisAlignment.start,children: [const SizedBox(width: 47,),Text("role".tr(), style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w600))]),
            const SizedBox(height: 78),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoleCard(),
            SizedBox(width: 54),
            RoleCard(isOrganizer:true)
              ],
            )
          ],
        ),
      )
    );
  }
}
