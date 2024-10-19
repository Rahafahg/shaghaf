import 'package:flutter/material.dart';

class SelectCategories extends StatelessWidget {
  const SelectCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Image.asset('assets/images/logo.png', height: 50),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text("What drives your passion?", style: TextStyle(fontSize: 24, fontFamily: "Poppins")),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/pottery.png'))),
                child: Checkbox(value: true, onChanged: (v){}),
              )
            ],
          ),
        )
      ),
    );
  }
}