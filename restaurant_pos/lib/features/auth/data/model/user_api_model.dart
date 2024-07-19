import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_pos/features/menu/data/model/menu_api_model.dart';

import '../../domain/entity/student_entity.dart';

part 'user_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel(
    fname: '',
    lname: '',
    phone: '',
    username: '',
    password: '',
  );
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String username;
  final String phone;
  final String password;

  AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  StudentEntity toEntity(List<MenuApiModel> data) => StudentEntity(
        id: id ?? '',
        fname: fname,
        lname: lname,
        image: image ?? '',
        phone: phone,
        username: username,
        password: password,
      );

  // Convert Entity to API Object
  AuthApiModel fromEntity(StudentEntity entity) => AuthApiModel(
        id: entity.id ?? '',
        fname: entity.fname,
        lname: entity.lname,
        image: entity.image ?? '',
        phone: entity.phone,
        username: entity.username,
        password: entity.password
      );



  @override
  String toString() {
    return 'AuthApiModel(id: $id, fname: $fname, lname: $lname, image: $image, phone: $phone, username: $username, password: $password)';
  }
}
