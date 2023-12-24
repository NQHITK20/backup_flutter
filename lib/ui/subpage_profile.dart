import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/providers/diachiviewmodal.dart';
import 'package:flutter_application_3/providers/mainviewmodel.dart';
import 'package:flutter_application_3/providers/profileviewmodal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'AppConstant.dart';
import 'custom_control.dart';

class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  static int idpage = 1;
  XFile? image;
  Future<void> init(Diachiviewmodal dcmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();
    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.province_id ||
        dcmodel.curDistId != profile.user.district_id ||
        dcmodel.curWardId != profile.user.ward_id) {
      viewmodel.playspiner();
      await dcmodel.initialize(profile.user.province_id,
          profile.user.district_id, profile.user.ward_id);
      viewmodel.hidespiner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<Diachiviewmodal>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                //--start header--//
                createHeader(size, profile, viewmodel),
                //end header ...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomInputTextFormField(
                      title: 'Điện thoại',
                      value: profile.user.phone,
                      width: size.width * 0.45,
                      callback: (output) {
                        profile.user.phone = output;
                        viewmodel.updatescreen();
                        viewmodel.setModified();
                      },
                      type: TextInputType.phone,
                    ),
                    CustomInputTextFormField(
                      title: 'Ngày sinh',
                      value: profile.user.birthday,
                      width: size.width * 0.45,
                      callback: (output) {
                        if (AppConstant.isDate(output)) {
                          profile.user.birthday = output;
                        }
                        viewmodel.updatescreen();
                        viewmodel.setModified();
                      },
                      type: TextInputType.datetime,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPlaceDropDown(
                        width: size.width * 0.45,
                        title: 'Thành phố/tỉnh',
                        valueId: profile.user.province_id,
                        valueName: profile.user.provincename,
                        callback: (outputId, outputName) async {
                          viewmodel.playspiner();
                          profile.user.province_id = outputId;
                          profile.user.provincename = outputName;
                          await dcmodel.SetCity(outputId);
                          profile.user.district_id = 0;
                          profile.user.ward_id = 0;
                          profile.user.dicstrictname = '';
                          profile.user.wardname = '';
                          viewmodel.setModified();
                          viewmodel.hidespiner();
                        },
                        list: dcmodel.listCity,
                        valueoutputBirthday: ''),
                    CustomPlaceDropDown(
                        width: size.width * 0.45,
                        title: 'Quận/huyện',
                        valueId: profile.user.district_id,
                        valueName: profile.user.dicstrictname,
                        callback: (outputId, outputName) async {
                          viewmodel.playspiner();
                          profile.user.district_id = outputId;
                          profile.user.dicstrictname = outputName;
                          profile.user.ward_id = 0;
                          profile.user.wardname = '';
                          await dcmodel.setDistrict(outputId);
                          viewmodel.setModified();
                          viewmodel.hidespiner();
                        },
                        list: dcmodel.listDistrict,
                        valueoutputBirthday: ''),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPlaceDropDown(
                        width: size.width * 0.45,
                        title: 'Huyện/xã',
                        valueId: profile.user.ward_id,
                        valueName: profile.user.wardname,
                        callback: (outputId, outputName) async {
                          viewmodel.playspiner();
                          profile.user.ward_id = outputId;
                          profile.user.wardname = outputName;
                          await dcmodel.setWard(outputId);
                          viewmodel.setModified();
                          viewmodel.hidespiner();
                        },
                        list: dcmodel.listWard,
                        valueoutputBirthday: ''),
                    CustomInputTextFormField(
                      title: 'Số nhà/tên đường',
                      value: profile.user.address,
                      width: size.width * 0.45,
                      callback: (output) {
                        profile.user.address = output;
                        viewmodel.updatescreen();
                        viewmodel.setModified();
                      },
                      type: TextInputType.streetAddress,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: size.width * 0.2,
                  width: size.width * 0.2,
                  child: QrImageView(
                    data: '{userid:' + profile.user.id.toString() + '}',
                    version: QrVersions.auto,
                    gapless: false,
                  ),
                )
              ],
            ),
            SizedBox(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: viewmodel.status == 1
                    ? CustomSpinner(
                        size: size,
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Container createHeader(
      Size size, Profile profile, ProfileViewModel viewmodel) {
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
                child: viewmodel.updateavatar == 1 && image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                viewmodel.uploadAvatar(image!);
                              },
                              child: Container(
                                  color: Colors.white,
                                  child: Icon(size: 30, Icons.save)),
                            ),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          viewmodel.setUpdateAvatar();
                        },
                        child: CustomAvatar1(size: size)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.user.user_name,
                style: AppConstant.textBodyfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    'Mssv:',
                    style: AppConstant.textBodywhite,
                  ),
                  Text(
                    profile.student.mssv,
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
                    profile.student.tenlop,
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
              ),
              SizedBox(
                  width: size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: viewmodel.modified == 1
                        ? GestureDetector(
                            onTap: () {
                              viewmodel.updateProfile();
                            },
                            child: Icon(Icons.save))
                        : Container(),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

