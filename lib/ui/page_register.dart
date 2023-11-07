// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/providers/registerviewmodal.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';
import 'package:flutter_application_3/ui/custom_control.dart';
import 'package:flutter_application_3/ui/page_login.dart';
import 'package:provider/provider.dart';

import 'page_main.dart';

class PageRegister extends StatelessWidget {
  PageRegister({super.key});
  static String routename = '/register';
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  bool agree = true;
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile(); //check login
    if (profile.token != '') {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Pagemain(),
              ));
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: viewmodel.status == 0 || viewmodel.status == 4
              ? Column(
                  children: [
                    Image(
                      image: AssetImage('verify.gif'),
                      width: 100,
                    ),
                    Text(
                      'Đăng ký thành công',
                      style: AppConstant.fancyheader,
                    ),
                    viewmodel.status == 3
                        ? Text('Bạn cần xác nhận email')
                        : Text(''),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.popAndPushNamed(
                              context, PageLogin.routename),
                          child: Text(
                            "Bấm vào đây",
                            style: AppConstant.link,
                          ),
                        ),
                        Text('để đăng nhập'),
                      ],
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Applogo(),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Add more name',
                          style: AppConstant.fancyheader,
                        ),
                        Text('Add more name 2', style: AppConstant.fancyheader),
                        const SizedBox(
                          height: 20,
                        ),
                        padding1(
                            textController: _usernameController,
                            hintText: 'Username',
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        padding1(
                            textController: _emailController,
                            hintText: 'Email',
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        padding1(
                            textController: _password1Controller,
                            hintText: 'Password1',
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        padding1(
                            textController: _password2Controller,
                            hintText: 'Password2',
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: viewmodel.agree,
                                onChanged: (value) {
                                  viewmodel.setAgree(value!);
                                }),
                            Text('Đồng ý  '),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Quy định'),
                                          content: SingleChildScrollView(
                                              child: Text(viewmodel.quydinh)),
                                        ));
                              },
                              child: Text(
                                'Quy định',
                                style: AppConstant.link,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          viewmodel.errormessage,
                          style: AppConstant.texterror,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                              onTap: () {
                                final email = _emailController.text.trim();
                                final username =
                                    _usernameController.text.trim();
                                final password1 =
                                    _password1Controller.text.trim();
                                final password2 =
                                    _password2Controller.text.trim();
                                viewmodel.register(
                                    email, username, password1, password2);
                              },
                              child: const contain1(TextButton: 'Đăng ký')),
                        ),
                      ],
                    ),
                    viewmodel.status == 1
                        ? CustomSpinner(
                            size: size,
                          )
                        : Container(),
                  ],
                ),
        ),
      )),
    );
  }
}
