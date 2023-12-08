import 'package:flutter/widgets.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //
  int modified = 0;
  void updatescreen() {
    notifyListeners();
  }

  void playspiner() {
    status = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
    }
  }

  void hidespiner() {
    status = 0;
    notifyListeners();
  }
}
