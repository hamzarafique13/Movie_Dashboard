import 'package:json_annotation/json_annotation.dart';

part 'usermodel.g.dart';

@JsonSerializable()
class UserModel {
  String title;
  String rating;
  String imagepath;
  String id;

  UserModel({
    required this.id,
    required this.title,
    required this.imagepath,
    required this.rating,
  });
  factory UserModel.fromJson(Map<String, dynamic> map) =>
      _$UserModelFromJson(map);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
