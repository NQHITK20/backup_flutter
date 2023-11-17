import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_3/model/profile.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  ApiService._internal();
  factory ApiService() {
    return _instance;
  }

  final url_login = 'https://chocaycanh.club/public/api/login';
  final url_register = 'https://chocaycanh.club/public/api/register';
  final url_forgot = 'https://chocaycanh.club/public/api/password/remind';
  late Dio _dio;
  void initialize() {
    _dio = Dio(BaseOptions(responseType: ResponseType.json));
  }

  Future<Response?> getUserInfo() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer' + Profile().token,
      'Accept': 'application/json',
    };
    String apiUrl = 'https://chocaycanh.club/api/me';
    try {
      final response =
          await _dio.get(apiUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> getStInfo() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer' + Profile().token,
      'Accept': 'application/json',
    };
    String apiUrl = 'https://chocaycanh.club/api/sinhvien/info';
    try {
      final response =
          await _dio.get(apiUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> loginUser(String username, String password) async {
    Map<dynamic, dynamic> param = {
      'username': username,
      'password': password,
      'device_name': 'android'
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };
    try {
      final response = await _dio.post(url_login,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> registerUser(
      String email, String username, String password) async {
    Map<dynamic, dynamic> param = {
      'username': username,
      'email': email,
      'password': password,
      'password_confirmation': password,
      'tos': 'true'
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };
    try {
      final response = await _dio.post(url_register,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 201) {
        print(response.data);
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response);
      }
    }
  }

  Future<Response?> ForgotPass(String email) async {
    Map<dynamic, dynamic> param = {
      'email': email,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };
    try {
      final response = await _dio.post(url_forgot,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
