import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/mainviewmodel.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';

class SubPageDiemdanh extends StatelessWidget {
  const SubPageDiemdanh({super.key});
  static int idpage = 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: AppConstant.backgroundcolor,
        child: Center(
          child: Text('Diemdanh'),
        ),
      ),
    );
  }
}
