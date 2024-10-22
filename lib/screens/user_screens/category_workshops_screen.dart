import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/data_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/models/categories_model.dart';
import 'package:shaghaf/widgets/cards/my_workshop_card.dart';
import 'package:shaghaf/widgets/cards/workshope_card.dart';

class CategoryWorkshopsScreen extends StatelessWidget {
  final CategoriesModel category;
  const CategoryWorkshopsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryWorkshops = GetIt.I.get<DataLayer>().workshops.where((workshop) => workshop.categoryId == category.categoryId).toList();
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>context.pop(), icon: const Icon(Icons.arrow_back_ios,color: Constants.lightGreen)),
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          category.categoryName,
          style: const TextStyle(fontSize: 20,fontFamily: "Poppins",color: Constants.textColor)
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Divider(height: 1),
          ),
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemBuilder: (context,index)=> WorkshopCard(workshop: categoryWorkshops[index], shape: 'rect',),
            separatorBuilder: (context,index)=> const SizedBox(height: 20,),
            itemCount: categoryWorkshops.length
          )
        ),
      )
    );
  }
}