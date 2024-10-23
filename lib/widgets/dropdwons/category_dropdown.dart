import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Workshop Category",
          style: TextStyle(
              color: Color(0xff313131), fontSize: 16, fontFamily: "Lato"),
        ),
        DropdownMenu(
            // controller: controller,
            hintText: "Category",
            textStyle: const TextStyle(
                fontSize: 15,
                fontFamily: "Poppins",
                color: Constants.textColor),
            inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13.0)),
                    borderSide: BorderSide(color: Constants.mainOrange)),
                filled: true,
                fillColor: Colors.white),
            width: context.getWidth(divideBy: 1.1),
            menuHeight: 150,
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            ),
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: "Art", label: "Art"),
              DropdownMenuEntry(value: "Handicrafts", label: "Handicrafts"),
              DropdownMenuEntry(value: "Pottery", label: "Pottery"),
              DropdownMenuEntry(value: "Cook", label: "Cook"),
              DropdownMenuEntry(value: "Fashion", label: "Fashion"),
              DropdownMenuEntry(value: "Photography", label: "Photography"),
              DropdownMenuEntry(value: "Social skills", label: "Social skills"),
              DropdownMenuEntry(value: "Others", label: "Others"),
            ]),
      ],
    );
  }
}

