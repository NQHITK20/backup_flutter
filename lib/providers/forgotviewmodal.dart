import 'package:flutter/material.dart';
import 'package:flutter_application_3/repositories/forgot_repository.dart';

class ForgotViewModal with ChangeNotifier {
  final forgotRepo = ForgotRepository();
  String errormessage = '';
  int status = 0; //0-chưa gửi ,1  Đang gửi ,2 lỗi,3 thành công
  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errormessage = '';
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += 'invalid email';
    }
    if (status != 2) {
      if (await forgotRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
        errormessage = 'email không tồn tại';
      }
    }
    notifyListeners();
  }
}
