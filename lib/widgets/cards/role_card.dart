import 'package:flutter/material.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/create_organizer_account_screen.dart';
import 'package:shaghaf/screens/auth_screens/create_user_account_screen.dart';

class RoleCard extends StatelessWidget {
  final bool? isOrganizer;
  const RoleCard({super.key, this.isOrganizer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(screen: isOrganizer!=null ? const CreateOrganizerAccountScreen() : const CreateUserAccountScreen()),
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 140,
        height: 140,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/${isOrganizer!=null ? 'organizer' : 'participant'}_role.png'))),
        child: Container(
          alignment: Alignment.center,
          width: context.getWidth(),
          height: 30,
          decoration: const BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
          child: Text(isOrganizer!=null ? "Organizer" : "Participant", style:Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}