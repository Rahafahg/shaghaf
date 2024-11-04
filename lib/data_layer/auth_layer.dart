import 'package:get_storage/get_storage.dart';
import 'package:shaghaf/models/organizer_model.dart';
import 'package:shaghaf/models/user_model.dart';

class AuthLayer {
  UserModel? user;
  OrganizerModel? organizer;
  bool didChooseFav = false;
  bool onboarding = false;
  bool admin = false;
  final box = GetStorage();

  AuthLayer() {
    // box.erase();
    if(box.hasData('onboarding')) {
      onboarding = true;
    }
    if (box.hasData('fav')) {
      if (box.read('fav') == true) {
        didChooseFav = true;
      }
    }
    if (box.hasData('admin')) {
      admin = true;
    }
    if (box.hasData('user')) {
      Map<String, dynamic> userAsMap = box.read('user');
      user = UserModel.fromJson(userAsMap);
    } else if (box.hasData('organizer')) {
      Map<String, dynamic> organizerAsMap = box.read('organizer');
      organizer = OrganizerModel.fromJson(organizerAsMap);
    }
  }

  bool isGuest() {
    if (!box.hasData('user')) {
      return true;
    }
    return false;
  }

  onboardingShown() {
    onboarding = true;
    box.write('onboarding', true);
  }

  favChosen() {
    didChooseFav = true;
    box.write('fav', true);
  }

  Future<void> setProfileImagePath(String path) async {
    await box.write('profile_image_path', path);
  }

  String? getProfileImagePath() {
    return box.read('profile_image_path');
  }
}
