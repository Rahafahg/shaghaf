import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_size.dart';

class OrganizersDropdown extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? onSelect;
  const OrganizersDropdown({super.key, required this.controller, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final organizers = GetIt.I.get<DataLayer>().organizers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose an Organizer".tr(context: context),style: const TextStyle(color: Color(0xff313131),fontSize: 16,),),
        const SizedBox(height: 8,),
        DropdownMenu(
          onSelected: onSelect,
          controller: controller,
          width: context.getWidth(divideBy: 2),
          menuHeight: 150,
          hintText: "Choose an Organizer".tr(context: context),
          textStyle: const TextStyle(fontSize: 15, color: Constants.textColor),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(13.0)),borderSide: BorderSide(color: Constants.mainOrange)),
          ),
          menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
          dropdownMenuEntries: List.generate(
            organizers.length, (index) => DropdownMenuEntry(
              value: organizers[index].name,
              label: organizers[index].name
            )
          )
        ),
      ],
    );
  }
}