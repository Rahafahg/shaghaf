import 'package:flutter/material.dart';

extension ScreenNav on BuildContext {
  push({required Widget screen, Function(dynamic)? updateInfo}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen)).then((test){
      if(updateInfo!=null) {
        updateInfo(test);
      }
    });
  }

  pushReplacement({required Widget screen}) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen));
  }

  pushRemove({required Widget screen}) {
    Navigator.pushAndRemoveUntil(this,MaterialPageRoute(builder: (context) => screen), (predicate) => false);
  }

  pop() {
    Navigator.pop(this);
  }

  popAndSave() {
    Navigator.pop(this,true);
  }
}