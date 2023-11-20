class Lop {
  int id;
  String ten;
  int idkhoa;
  int status;
  Lop({
    this.id = 0,
    this.ten = '',
    this.idkhoa = 0,
    this.status = 0,
  });
  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
        id: json['id'],
        ten: json['ten'],
        idkhoa: json['idkhoa'],
        status: json['status']);
  }
  factory Lop.fromLop(Lop lop) {
    return Lop(
        id: lop.id, ten: lop.ten, idkhoa: lop.idkhoa, status: lop.status);
  }
}
