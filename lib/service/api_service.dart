import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_3/model/profile.dart';
import 'package:http/http.dart' as http;

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

  Future<List<dynamic>?> getListCity() async {
    Profile profile = Profile();
    String api_url = 'https://chocaycanh.club/api/getjstinh';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(api_url), headers: headers);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>?> getListDistrict(int id) async {
    Profile profile = Profile();
    String api_url =
        'https://chocaycanh.club/api/getjshuyen?id=' + id.toString();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(api_url), headers: headers);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>?> getListWard(int id) async {
    Profile profile = Profile();
    String api_url = 'https://chocaycanh.club/api/getjsxa?id=' + id.toString();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(api_url), headers: headers);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Response?> dangkylop() async {
    Profile profile = Profile();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    Map<String, dynamic> param = {
      'id': profile.student.idlop,
      'mssv': profile.student.mssv
    };
    String apiUrl = 'https://chocaycanh.club/api/lophoc/dangky';
    try {
      final response = await _dio.post(apiUrl,
          options: Options(headers: headers), data: jsonEncode(param));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> updateProfile() async {
    Profile profile = Profile();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    String birthday = '';
    Map<String, dynamic> param = {
      'first_name': profile.user.first_name,
      'last_name': '',
      'phone': profile.user.phone,
      'address': profile.user.address ?? '',
      'provinceid': profile.user.province_id,
      'provincename': profile.user.provincename ?? '',
      'districtid': profile.user.district_id,
      'districname': profile.user.dicstrictname ?? '',
      'wardid': profile.user.ward_id,
      'wardname': profile.user.wardname ?? '',
      'street': profile.user.address ?? '',
      'birthday': birthday,
    };
    print(param);
    String apiUrl = 'https://chocaycanh.club/api/me/details';
    try {
      final response = await _dio.patch(apiUrl,
          options: Options(headers: headers), data: jsonEncode(param));
      if (response.statusCode == 200) {
        print(response);
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        print('Error: $e');
        print(e.message);
        print(e.error);
        print(e.response);
      }
    }
    return null;
  }

  Future<Response?> getDsLop() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    String apiUrl = 'https://chocaycanh.club/api/lophoc/ds';
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

  Future<Response?> getUserInfo() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
      'Accept': 'application/json',
    };
    String apiUrl = 'https://chocaycanh.club/public/api/me';
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
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + Profile().token,
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
      'Content-Type': 'application/json; charset=UTF-8',
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
      'Content-Type': 'application/json; charset=UTF-8',
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
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final response = await _dio.post(url_forgot,
          data: jsonEncode(param), options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      if (e is DioException) {
        print('Error: $e');
        print(e.message);
        print(e.error);
        print(e.response);
      }
    }
    return null;
  }
}
