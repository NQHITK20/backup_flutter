import 'package:flutter/widgets.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //
  void updatescreen() {
    notifyListeners();
  }

  void playspiner() {
    status = 1;
    notifyListeners();
  }

  void hidespiner() {
    status = 0;
    notifyListeners();
  }
}
