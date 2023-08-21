// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezedmoviemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DbMovieModel _$$_DbMovieModelFromJson(Map<String, dynamic> json) =>
    _$_DbMovieModel(
      name: json['name'] as String,
      title: json['title'] as String,
      rating: json['rating'] as String,
      image: json['image'] as String,
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_DbMovieModelToJson(_$_DbMovieModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'rating': instance.rating,
      'image': instance.image,
      'id': instance.id,
      'date': instance.date.toIso8601String(),
    };
