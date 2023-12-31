import 'package:flutter/material.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';
import 'package:flutter_application_3/ui/page_forgot.dart';
import 'package:flutter_application_3/ui/page_register.dart';
import 'package:provider/provider.dart';

import '../providers/loginviewmodal.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodal = Provider.of<LoginViewModal>(context);
    final size = MediaQuery.of(context).size;
    if (viewmodal.status == 3) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.popAndPushNamed(context, Pagemain.routename);
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Applogo(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'hello',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const Text('Love Laura,still mis u <3',
                        style: TextStyle(fontSize: 25)),
                    const SizedBox(
                      height: 20,
                    ),
                    padding1(
                      hintText: 'username',
                      textController: _emailController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    padding1(
                      hintText: 'password',
                      textController: _passwordController,
                      obscureText: true,
                    ),
                    viewmodal.status == 2
                        ? Text(
                            viewmodal.errorMessage,
                            style: const TextStyle(color: Colors.orange),
                          )
                        : const Text(''),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        String username = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        viewmodal.login(username, password);
                      },
                      child: const contain1(
                        TextButton: 'Đăng nhập',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Chưa có tài khoản?'),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .popAndPushNamed(PageRegister.routename),
                          child: Text(
                            ' Đăng ký ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple[300]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .popAndPushNamed(PageForgot.routename),
                      child: Text(
                        'Quên mật khẩu?',
                        style: AppConstant.link,
                      ),
                    )
                  ],
                ),
              ),
              viewmodal.status == 1 ? CustomSpinner(size: size) : Container()
            ],
          ),
        ),
      )),
    );
  }
}
