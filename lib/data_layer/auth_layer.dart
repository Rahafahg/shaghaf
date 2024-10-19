import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:shaghaf/models/user_model.dart';

class AuthLayer {
  UserModel? user;
  final box = GetStorage();
  bool didChooseFav = false;

  AuthLayer() {
    if(box.hasData('fav')) {
      if(box.read('fav')==true) {
        didChooseFav = true;
        log('user already chose fav ... moving to home');
      }
    }
    if (box.hasData('user')) {
      Map<String, dynamic> userAsMap = box.read('user');
      user = UserModel.fromJson(userAsMap);
      log('user found ${user!.firstName}');
    }
    else {
      log('user not found');
    }
  }

  bool isGuest() {
    if (!box.hasData('user')) {
      return true;
    }
    return false;
  }

  favChosen(){
    didChooseFav = true;
    box.write('fav', true);
  }
}