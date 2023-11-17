import 'package:flutter_application_3/model/profile.dart';
import 'package:flutter_application_3/model/student.dart';
import 'package:flutter_application_3/service/api_service.dart';

class StudentRepository {
  ApiService api = ApiService();
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
