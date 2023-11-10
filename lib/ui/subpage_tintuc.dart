import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageTinTuc extends StatelessWidget {
  const SubPageTinTuc({super.key});
  static int idpage = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: AppConstant.backgroundcolor,
        child: Center(
          child: Text('tin tức'),
        ),
      ),
    );
  }
}
