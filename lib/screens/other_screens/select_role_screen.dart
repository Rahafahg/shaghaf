import 'package:flutter/material.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/widgets/cards/role_card.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.getWidth(),
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/auth_bg.png'), fit: BoxFit.cover),),
        child: Column(
          children: [
            Container(padding: const EdgeInsets.only(top: 61, left: 92),child: Image.asset('assets/images/logo.png')),
            const SizedBox(height: 55,),
            Row(mainAxisAlignment: MainAxisAlignment.start,children: [const SizedBox(width: 47,),Text("What are you ?", style: Theme.of(context).textTheme.bodyMedium,)]),
            const SizedBox(height: 40),
            const RoleCard(),
            const SizedBox(height: 40),
            const RoleCard(isOrganizer:true)
          ],
        ),
      )
    );
  }
}