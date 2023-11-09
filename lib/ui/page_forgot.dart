import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/forgotviewmodal.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';
import 'package:flutter_application_3/ui/custom_control.dart';
import 'package:provider/provider.dart';

import 'page_login.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routename = '/forgot';
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodal = Provider.of<ForgotViewModal>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: viewmodal.status == 3
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('verify.gif'),
                        width: 100,
                      ),
                      Text(
                        ' Gửi yêu cầu thành công.Truy cập vào email để và làm theo hướng dẫn',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewmodal.status = 0;
                              Navigator.popAndPushNamed(
                                  context, PageLogin.routename);
                            },
                            child: Text(
                              "Bấm vào đây",
                              style: AppConstant.link,
                            ),
                          ),
                          Text('để đăng nhập'),
                        ],
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('email.gif'),
                            width: 150,
                          ),
                          Text(
                              'Hãy điền email để thực hiện quy trình tái tạo mật khẩu'),
                          SizedBox(
                            height: 10,
                          ),
                          padding1(
                              textController: _emailController,
                              hintText: 'email',
                              obscureText: false),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            viewmodal.errormessage,
                            style: AppConstant.texterror,
                          ),
                          GestureDetector(
                              onTap: () {
                                final email = _emailController.text.trim();
                                viewmodal.forgotPassword(email);
                              },
                              child: contain1(TextButton: 'Gửi yêu cầu')),
                        ],
                      ),
                    ),
                    viewmodal.status == 1
                        ? CustomSpinner(
                            size: size,
                          )
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }
}
