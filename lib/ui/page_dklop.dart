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
                value: ten,
                callback: (output) {
                  ten = output;
                },
              ),
              CustomInputTextFormField(
                width: size.width,
                title: 'Mssv',
                value: mssv,
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
                              list: listlop!);
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
                      list: listlop!),
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

class CustomInputDropDown extends StatefulWidget {
  CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.valueName,
    required this.callback,
    required this.list,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;
  final Function(int outputId, String outputName) callback;

  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = '';
  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valueName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textBody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  outputName == '' ? 'Không có' : outputName,
                  style: AppConstant.textBodyfocus,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200]),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Container(
                                width: widget.width * 0.8,
                                child: Text(
                                  e.ten,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                )),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}

class CustomInputTextFormField extends StatefulWidget {
  CustomInputTextFormField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
  });

  final double width;
  final String title;
  final String value;
  final Function(String output) callback;

  @override
  State<CustomInputTextFormField> createState() =>
      _CustomInputTextFormFieldState();
}

class _CustomInputTextFormFieldState extends State<CustomInputTextFormField> {
  int status = 0;
  String output = '';
  @override
  void initState() {
    // TODO: implement initState
    output = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textBody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(
                  output == '' ? 'Không có' : output,
                  style: AppConstant.textBodyfocus,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200]),
                    width: widget.width - 50,
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      initialValue: output,
                      onChanged: (value) {
                        setState(() {
                          output = value;
                          widget.callback(output);
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 0;
                        widget.callback(output);
                      });
                    },
                    child: Icon(
                      Icons.save,
                      size: 18,
                    ),
                  )
                ],
              ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
