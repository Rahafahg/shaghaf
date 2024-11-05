import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';

class SearchField extends StatelessWidget {
  final Function(String)? onChanged;
  const SearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: "Search".tr(),
        hintStyle: TextStyle(
            fontSize: 12, color: Theme.of(context).textTheme.bodyLarge!.color),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimaryFixed,
        prefixIcon: const Icon(Icons.search, color: Constants.lightGreen),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
