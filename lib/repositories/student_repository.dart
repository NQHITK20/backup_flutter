import 'package:flutter_application_3/model/student.dart';
import 'package:flutter_application_3/service/api_service.dart';

class StudentRepository {
  ApiService api = ApiService();
  Future<bool> dangkylop() async {
    bool kq = false;
    var res = await api.dangkylop();
    if (res != null) {
      kq = true;
    }
    return kq;
  }

  Future<Student> getStudentInfo() async {
    Student student = Student();
    var res = await api.getStInfo();
    if (res != null) {
      var data = res.data;
      student = Student.fromJson(data);
      // Profile().student = Student.fromStudent(student);
    }
    return student;
  }
}
