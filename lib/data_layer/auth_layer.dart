import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:shaghaf/models/organizer_model.dart';
import 'package:shaghaf/models/user_model.dart';

class AuthLayer {
  UserModel? user;
  OrganizerModel? organizer;
  final box = GetStorage();

  AuthLayer() {
    box.erase();
    if (box.hasData('user')) {
      Map<String, dynamic> userAsMap = box.read('user');
      user = UserModel.fromJson(userAsMap);
      log('user found ${user!.firstName}');
    } else if (box.hasData('organizer')) {
      Map<String, dynamic> organizerAsMap = box.read('organizer');
      organizer = OrganizerModel.fromJson(organizerAsMap);
      log('user found ${organizer!.name}');
    } else {
      log('user not found');
    }
  }

  bool isGuest() {
    if (!box.hasData('user')) {
      return true;
    }
    return false;
  }
}
