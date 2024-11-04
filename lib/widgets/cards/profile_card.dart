import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class ProfileCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const ProfileCard({super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(offset: Offset(0, 4),blurRadius: 8,color: Color.fromARGB(104, 222, 101, 49),spreadRadius: 0)],
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(icon,color: Constants.mainOrange,),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(fontSize: 16,color: Theme.of(context).textTheme.bodyLarge!.color)
            ) // 17 pop ?
          ],
        ),
      ),
    );
  }
}