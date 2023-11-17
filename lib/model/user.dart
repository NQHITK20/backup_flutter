import 'package:flutter/foundation.dart';

class User {
  int id;
  String first_name;
  String last_name;
  String user_name;
  String email;
  String phone;
  String avatar;
  String address;
  int role_id;
  String status;
  int province_id;
  int district_id;
  int ward_id;
  String provincename;
  String dicstrictname;
  String wardname;
  String birthday;
  User({
    this.id = 0,
    this.first_name = "",
    this.last_name = "",
    this.user_name = "",
    this.email = "",
    this.phone = "",
    this.avatar = "",
    this.address = "",
    this.role_id = 4,
    this.status = "Active",
    this.province_id = 0,
    this.district_id = 0,
    this.ward_id = 0,
    this.provincename = "",
    this.dicstrictname = "",
    this.wardname = "",
    this.birthday = "",
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'] ?? "",
      last_name: json['last_name'] ?? "",
      user_name: json['user_name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
      address: json['address'] ?? "",
      role_id: json['role_id'] ?? 4,
      status: json['status'] ?? "",
      province_id: json['province_id'] ?? 0,
      district_id: json['district_id'] ?? 0,
      ward_id: json['ward_id'] ?? 0,
      provincename: json['provincename'] ?? "",
      dicstrictname: json['dicstrictname'] ?? "",
      wardname: json['wardname'] ?? "",
      birthday: json['birthday'] ?? "",
    );
  }
  factory User.fromUser(User value) {
    return User(
      id: value.id,
      first_name: value.first_name,
      last_name: value.last_name,
      user_name: value.user_name,
      email: value.email,
      phone: value.phone,
      avatar: value.avatar,
      address: value.address,
      role_id: value.role_id,
      status: value.status,
      province_id: value.province_id,
      district_id: value.district_id,
      ward_id: value.ward_id,
      provincename: value.provincename,
      dicstrictname: value.dicstrictname,
      wardname: value.wardname,
      birthday: value.birthday,
    );
  }
}
