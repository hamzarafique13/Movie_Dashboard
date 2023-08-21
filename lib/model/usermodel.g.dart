// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imagepath: json['imagepath'] as String,
      rating: json['rating'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'title': instance.title,
      'rating': instance.rating,
      'imagepath': instance.imagepath,
      'id': instance.id,
    };
