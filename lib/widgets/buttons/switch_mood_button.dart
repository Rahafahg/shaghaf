import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/theme/bloc/theme_bloc.dart';

class SwitchMoodButton extends StatelessWidget {
  const SwitchMoodButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    color: Color.fromARGB(104, 222, 101, 49),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: IconButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                  icon: const Icon(Icons.dark_mode),
                  color: Constants.mainOrange,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "Mode".tr(),
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
