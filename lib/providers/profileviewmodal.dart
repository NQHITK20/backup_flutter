import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/model/user.dart';
import 'package:flutter_application_3/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //
  int modified = 0;
  int updateavatar = 0;
  void updatescreen() {
    notifyListeners();
  }

  void setUpdateAvatar() {
    updateavatar = 1;
    notifyListeners();
  }

  void playspiner() {
    status = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
    }
  }

  void hidespiner() {
    status = 0;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    modified = 0;
    updateProfile();
  }

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().uploadAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updateavatar = 0;
    status = 0;
    notifyListeners();
  }
}
