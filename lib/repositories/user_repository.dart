import 'dart:io';

import 'package:flutter_application_3/model/user.dart';
import 'package:flutter_application_3/service/api_service.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

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

  Future<void> uploadAvatar(XFile image) async {
    ApiService api = ApiService();
    if (image != null) {
      //resize the image
      final img.Image originalImage =
          img.decodeImage(File(image.path).readAsBytesSync())!;
      final img.Image resizedImage = img.copyResize(originalImage, width: 300);

      final File resizedFile =
          File(image.path.replaceAll('.jpg', '_resized.jpg'))
            ..writeAsBytes(img.encodeJpg(resizedImage));
      await api.uploadAvatarToSever(File(resizedFile.path));
    }
  }
}
