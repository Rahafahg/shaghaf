import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class CategoryDropDown extends StatelessWidget {
  final TextEditingController controller;
  const CategoryDropDown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final categories = GetIt.I.get<DataLayer>().categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Workshop Category",
          style: TextStyle(color: Color(0xff313131), fontSize: 16, fontFamily: "Lato"),
        ),
        DropdownMenu(
          controller: controller,
          hintText: "Category",
          textStyle: const TextStyle(fontSize: 15,fontFamily: "Poppins",color: Constants.textColor),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(13.0)),
              borderSide: BorderSide(color: Constants.mainOrange)
            ),
          ),
          width: context.getWidth(divideBy: 1.1),
          menuHeight: 150,
          menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
          dropdownMenuEntries: List.generate(categories.length, (index)=>DropdownMenuEntry(value: categories[index].categoryName, label: categories[index].categoryName))
        ),
      ],
    );
  }
}