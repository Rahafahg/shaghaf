import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/user_screens/user_home_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
class SelectCategoriesScreen extends StatelessWidget {
  const SelectCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> selected = [];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Image.asset('assets/images/logo.png',height: 50)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("What drives your passion?",style: TextStyle(fontSize: 24, fontFamily: "Poppins")),
                const SizedBox(height: 20),
                MultiSelectContainer(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  items: List.generate(8, (index) => MultiSelectCard(
                    value: 'value${index + 1}',
                    decorations: MultiSelectItemDecorations(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/pottery.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      selectedDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: const AssetImage('assets/images/pottery.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                          Constants.mainOrange.withOpacity(0.3),
                            BlendMode.color,
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 160,
                      height: 140,
                      alignment: Alignment.center,
                      child: Text('category ${index+1}',style: const TextStyle(color: Colors.white,fontSize: 24, fontFamily: "Poppins")),
                    ),
                  )),
                  onChange: (selectedItems, selectedItem) {
                    selected.contains(selectedItem) ? selected.remove(selectedItem) : selected.add(selectedItem);
                    log(selected.toString());
                    log(selectedItems.toString());
                  },
                ),
                const SizedBox(height: 40),
                MainButton(text: "Continue", width: context.getWidth(), onPressed: () {
                  if(selected.length < 3) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Choose at least 3 categories')));
                  }
                  else {
                    GetIt.I.get<AuthLayer>().favChosen();
                    context.pushRemove(screen: const UserHomeScreen());
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}