import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class CategoryDropDown extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?)? onSelected; // is it final ?
  const CategoryDropDown(
      {super.key, required this.controller, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final categories = GetIt.I.get<DataLayer>().categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Workshop Category".tr(context: context),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownMenu(
            onSelected: onSelected,
            controller: controller,
            hintText: "Category".tr(context: context),
            textStyle:
                const TextStyle(fontSize: 15, color: Constants.textColor),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  borderSide: BorderSide(color: Constants.mainOrange)),
            ),
            width: context.getWidth(divideBy: 1.1),
            menuHeight: 150,
            menuStyle: MenuStyle(
                backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.onSecondaryContainer,
            )),
            dropdownMenuEntries: List.generate(
                categories.length,
                (index) => DropdownMenuEntry(
                    value: categories[index].categoryName,
                    label: categories[index].categoryName)))
      ],
    );
  }
}
