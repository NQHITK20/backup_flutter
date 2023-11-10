import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/mainviewmodel.dart';
import 'package:flutter_application_3/ui/AppConstant.dart';

class SubPageTimKiem extends StatelessWidget {
  const SubPageTimKiem({super.key});
  static int idpage = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: AppConstant.backgroundcolor,
        child: Center(
          child: Text('TimKiem'),
        ),
      ),
    );
  }
}
