import 'package:flutter/material.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';

import '../model/profile.dart';

class PageDangkyLop extends StatelessWidget {
  const PageDangkyLop({super.key});

  @override
  Widget build(BuildContext context) {
    Profile profile = Profile();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tên:'),
                Text(profile.user.first_name + 'Ten Ten Ten'),
                Divider(
                  thickness: 1,
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
