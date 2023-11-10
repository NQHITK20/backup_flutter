import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  int menustatus = 0; //o close,1 open
  int activemenu = 0; //index cua menu
  void toggleMenu() {
    if (menustatus == 0) {
      menustatus = 1;
    } else {
      menustatus = 0;
    }
    notifyListeners();
  }

  void closeMenu() {
    menustatus = 0;
    notifyListeners();
  }

  void setActiveMenu(int index) {
    activemenu = index;
    notifyListeners();
  }
}
