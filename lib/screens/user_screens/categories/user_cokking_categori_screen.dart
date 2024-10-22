import 'package:flutter/material.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/extensions/screen_nav.dart';

class UserCokkingCategoriScreen extends StatelessWidget {
  const UserCokkingCategoriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey.shade500,
            ),
          ),
          forceMaterialTransparency: true,
          centerTitle: true,
          title: const Text(
            "My Workshops",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                color: Constants.textColor),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Divider(height: 1),
            ),
          )),
      body: Center(
        child: Text("hii"),
      ),
    );
  }
}
