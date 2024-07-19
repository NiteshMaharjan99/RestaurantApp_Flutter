import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String phone;
  final String? image;
  final String username;
  final String password;

  const StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    this.image,
    required this.username,
    required this.password,
  });

  factory StudentEntity.fromJson(Map<String, dynamic> json) => StudentEntity(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        image: json["image"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "image": image,
        "phone": phone,
        "username": username,
        "password": password,
      };

  @override
  List<Object?> get props =>
      [id, fname, lname, image, phone, username, password];
}
