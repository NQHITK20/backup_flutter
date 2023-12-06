import 'package:flutter_application_3/model/place.dart';

import '../service/api_service.dart';

class PlaceRepository {
  Future<List<City>> getListCity() async {
    List<City> list = [];
    var data = await ApiService().getListCity();
    if (data != null) {
      for (var item in data) {
        var city = City.fromJson(item);
        list.add(city);
      }
    }
    return list;
  }

  Future<List<District>> getListDistrict(int id) async {
    List<District> list = [];
    var data = await ApiService().getListDistrict(id);
    if (data != null) {
      for (var item in data) {
        var district = District.fromJson(item);
        list.add(district);
      }
    }
    return list;
  }

  Future<List<Ward>> getListWard(int id) async {
    List<Ward> list = [];
    var data = await ApiService().getListWard(id);
    if (data != null) {
      for (var item in data) {
        var ward = Ward.fromJson(item);
        list.add(ward);
      }
    }
    return list;
  }
}
