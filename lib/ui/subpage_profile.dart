import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/providers/mainviewmodel.dart';
import 'package:flutter_application_3/providers/profileviewmodal.dart';
import 'package:provider/provider.dart';

import 'AppConstant.dart';
import 'custom_control.dart';

class SubPageProfile extends StatelessWidget {
  const SubPageProfile({super.key});
  static int idpage = 1;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            //--start header--//
            createHeader(size, profile),
            //end header ...

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomInputTextFormField(
                  title: 'Điện thoại',
                  value: '8712481283',
                  width: size.width * 0.45,
                  callback: (output) {
                    profile.user.phone = output;
                    viewmodel.updatescreen();
                  },
                  type: TextInputType.phone,
                ),
                CustomInputTextFormField(
                  title: 'Ngày sinh',
                  value: '25/12/2001',
                  width: size.width * 0.45,
                  callback: (output) {
                    if (AppConstant.isDate(output)) {
                      profile.user.birthday = output;
                    }
                    viewmodel.updatescreen();
                  },
                  type: TextInputType.datetime,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container createHeader(Size size, Profile profile) {
    return Container(
      height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.deepPurple[200],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textBodyfocuswhite,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAvatar1(size: size),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User name 1',
                style: AppConstant.textBodyfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    'Mssv:',
                    style: AppConstant.textBodywhite,
                  ),
                  Text(
                    '2121212',
                    style: AppConstant.textBodyfocuswhitebold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Lớp: ',
                    style: AppConstant.textBodywhite,
                  ),
                  Text(
                    'cnttk20',
                    style: AppConstant.textBodyfocuswhitebold,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          ' (Chưa duyệt)',
                          style: AppConstant.textBodyfocuswhite,
                        )
                      : Text('')
                ],
              ),
              Row(
                children: [
                  Text(
                    'Vai trò: ',
                    style: AppConstant.textBodywhite,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          'Sinh viên',
                          style: AppConstant.textBodyfocuswhitebold,
                        )
                      : Text(
                          'Giảng viên',
                          style: AppConstant.textBodyfocuswhitebold,
                        ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
