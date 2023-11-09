import 'package:dio/dio.dart';
import 'package:flutter_application_3/service/api_service.dart';

class ForgotRepository {
  final ApiService api = ApiService();
  Future<bool> forgotPassword(String email) async {
    final res = await api.ForgotPass(email);
    if (res != null) {
      return true;
    } else {
      return false;
    }
  }
}
