import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:shaghaf/constants/constants.dart';
class SelectCategoriesScreen extends StatelessWidget {
  const SelectCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Image.asset('assets/images/logo.png',height: 50)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                onChange: (selectedItems, selectedItem) => log(selectedItems.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}