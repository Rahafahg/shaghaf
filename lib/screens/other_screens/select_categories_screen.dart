import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/screens/navigation_screen/navigation_screen.dart';
import 'package:shaghaf/screens/user_screens/home/user_home_screen.dart';
import 'package:shaghaf/widgets/buttons/main_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectCategoriesScreen extends StatelessWidget {
  const SelectCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> selected = [];
    final categories = GetIt.I.get<DataLayer>().categories;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset('assets/images/logo.png', height: 50)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("What drives your passion?",
                    style: TextStyle(fontSize: 24, fontFamily: "Poppins")),
                const SizedBox(height: 20),
                MultiSelectContainer(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  items: List.generate(
                      categories.length,
                      (index) => MultiSelectCard(
                            value: categories[index].categoryName,
                            decorations: MultiSelectItemDecorations(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(categories[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              selectedDecoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(categories[index].image),
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
                              child: Text(categories[index].categoryName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: "Poppins")),
                            ),
                          )),
                  onChange: (selectedItems, selectedItem) {
                    selected.contains(selectedItem)
                        ? selected.remove(selectedItem)
                        : selected.add(selectedItem);
                    log(selected.toString());
                    log(selectedItems.toString());
                  },
                ),
                const SizedBox(height: 40),
                MainButton(
                    text: "Continue",
                    width: context.getWidth(),
                    onPressed: () async {
                      if (selected.length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Choose at least 3 categories')));
                      } else {
                        final List<CategoriesModel> favCategories = [];
                        for (String category in selected) {
                          GetIt.I.get<DataLayer>().categories.forEach((cat) {
                            if (cat.categoryName == category) {
                              favCategories.add(cat);
                            }
                          });
                        }

                        log(selected.toString());
                        log(favCategories.length.toString());
                        GetIt.I.get<AuthLayer>().favChosen();

                        await GetIt.I
                            .get<SupabaseLayer>()
                            .supabase
                            .from('favorite_categories')
                            .insert({
                          'user_id': GetIt.I.get<AuthLayer>().user!.userId,
                          'category_id': favCategories.first.categoryId
                        });
                        context.pushRemove(screen: const NavigationScreen());
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
