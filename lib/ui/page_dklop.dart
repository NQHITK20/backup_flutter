import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/student.dart';
import 'package:flutter_application_3/repositories/lop_repository.dart';
import 'package:flutter_application_3/repositories/student_repository.dart';
import 'package:flutter_application_3/repositories/user_repository.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';
import 'package:flutter_application_3/ui/custom_control.dart';
import 'package:flutter_application_3/ui/page_main.dart';

import '../model/lop.dart';
import '../model/profile.dart';

class PageDangkyLop extends StatefulWidget {
  PageDangkyLop({super.key});

  @override
  State<PageDangkyLop> createState() => _PageDangkyLopState();
}

class _PageDangkyLopState extends State<PageDangkyLop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';

  @override
  void initState() {
    // TODO: implement initState
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Thêm thông tin cơ bản',
                style: AppConstant.fancyheader2,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Check kĩ giùm nha',
                style: AppConstant.texterror,
              ),
              SizedBox(
                height: 20,
              ),
              CustomInputTextFormField(
                width: size.width,
                title: 'Tên',
                value: profile.user.user_name,
                callback: (output) {
                  ten = output;
                },
              ),
              CustomInputTextFormField(
                width: size.width,
                title: 'Mssv',
                value: profile.student.mssv,
                callback: (output) {
                  mssv = output;
                },
              ),
              listlop!.isEmpty
                  ? FutureBuilder(
                      future: LopRepository().getDsLop(),
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listlop = snapshot.data;
                          return CustomInputDropDown(
                            width: size.width,
                            title: 'Lớp',
                            valueId: idlop,
                            valueName: tenlop,
                            callback: (outputId, outputName) => {
                              idlop = outputId,
                              tenlop = outputName,
                            },
                            list: listlop!,
                            valueoutputBirthday: '',
                          );
                        } else {
                          return Text('bug cmnr');
                        }
                      })
                  : CustomInputDropDown(
                      width: size.width,
                      title: 'Lớp',
                      valueId: idlop,
                      valueName: tenlop,
                      callback: (outputId, outputName) => {
                        idlop = outputId,
                        tenlop = outputName,
                      },
                      list: listlop!,
                      valueoutputBirthday: '',
                    ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    profile.student.mssv = mssv;
                    profile.student.idlop = idlop;
                    profile.student.tenlop = tenlop;
                    profile.user.first_name = ten;
                    await UserRepository().updateProfile();
                    await StudentRepository().dangkylop();
                  },
                  child: contain1(TextButton: 'Lưu')),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, Pagemain.routename);
                },
                child: Text(
                  'Rời trang >>',
                  style: AppConstant.link,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
