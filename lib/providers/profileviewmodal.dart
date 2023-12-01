import 'package:flutter/widgets.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //
  void updatescreen() {
    notifyListeners();
  }
}
