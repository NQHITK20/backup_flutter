import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/student.dart';
import 'package:flutter_application_3/model/user.dart';
import 'package:flutter_application_3/repositories/login_repository.dart';
import 'package:flutter_application_3/repositories/student_repository.dart';
import 'package:flutter_application_3/repositories/user_repository.dart';

class LoginViewModal with ChangeNotifier {
  String errorMessage = '';
  int status = 0; //0-not login,1-waiting,2-error,3-already logged
  LoginRepository loginRepo = LoginRepository();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
      if (profile.token == '') {
        status = 2;
        errorMessage = 'tài khoản hoặc mật khẩu sai cmnr';
      } else {
   //đăng nhập ngon r,lấy user zzz
        var student = await StudentRepository().getStudentInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
        status = 3;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
