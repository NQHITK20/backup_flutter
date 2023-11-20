import 'package:flutter_application_3/model/user.dart';
import 'package:flutter_application_3/service/api_service.dart';

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final res = await ApiService().getUserInfo();
    if (res != null) {
      var json = res.data['data'];
      user = User.fromJson(json);
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var res = await ApiService().updateProfile();
    if (res != null) {
      kq = true;
    }
    return kq;
  }
}
