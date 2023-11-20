import 'package:flutter/material.dart';
import 'package:flutter_application_3/repositories/lop_repository.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';

import '../model/lop.dart';
import '../model/profile.dart';

class PageDangkyLop extends StatelessWidget {
  const PageDangkyLop({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Profile profile = Profile();
    String mssv = profile.student.mssv;
    String ten = profile.user.first_name;
    int idlop = profile.student.idlop;
    String tenlop = profile.student.tenlop;
    List<Lop>? listlop = [];
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
              listlop.isEmpty
                  ? FutureBuilder(
                      future: LopRepository().getDsLop(),
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listlop = snapshot.data;
                          return Text('lop:' + listlop!.length.toString());
                        } else {
                          return Text('bug cmnr');
                        }
                      })
                  : Text('lop:' + listlop!.length.toString()),
            ],
          ),
        )),
      ),
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
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200]),
                    width: widget.width - 25,
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      initialValue: output,
                      onChanged: (value) {
                        setState(() {
                          output = value;
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
