import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/repositories/register_repository.dart';

class RegisterViewModel with ChangeNotifier {
  int status =
      0; //0-chưa dk   //1-đang dk  //2-đk-lỗi  //3-đk cần xm email  //4-dk ko xm email
  String errormessage = '';
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quydinh = 'Khi tham gia đồng ý với các điều khoản sau:\n' +
      '1.Các thông tin chia sẽ được chia sẽ với các thành học\n' +
      '2.Thông tin của bạn có thể ảnh hưởng học tập ở trường\n' +
      '3.Thông tin của bạn sẽ được xóa vĩnh viễn khi có yêu cầu xóa thông tin\n';

  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(
      String email, String username, String password1, String password2) async {
    status = 1;
    notifyListeners();
    if (agree == false) {
      status = 2;
      errormessage += 'Bạn phải đồng ý với điều khoản trước khi đăng ký';
    }
    if (email.isEmpty || username.isEmpty || password1.isEmpty) {
      status = 2;
      errormessage += 'missing input parameter';
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += 'invalid email';
    }
    if (password1.length < 8) {
      status = 2;
      errormessage += 'mật khẩu yếu';
    }
    if (password1 != password2) {
      status = 2;
      errormessage += 'pass1 khác pass2';
    }
    if (status != 2) {
      status = await registerRepo.register(email, username, password1);
    }
    //sử dụng repository gọi hàm login và lấy kết quả
    notifyListeners();
  }
}
