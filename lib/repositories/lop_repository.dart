import 'package:flutter_application_3/model/lop.dart';
import 'package:flutter_application_3/service/api_service.dart';

class LopRepository {
  Future<List<Lop>> getDsLop() async {
    List<Lop> list = [];
    list.add(Lop(ten: 'cnttk20'));
    final res = await ApiService().getDsLop();
    if (res != null) {
      var data = res.data['data'];
      for (var item in data) {
        var lop = Lop.fromJson(item);
        list.add(lop);
      }
    }
    return list;
  }
}
