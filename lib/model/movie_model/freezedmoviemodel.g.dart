// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezedmoviemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DbMovieModel _$$_DbMovieModelFromJson(Map<String, dynamic> json) =>
    _$_DbMovieModel(
      name: json['name'] as String,
      genremovie: json['genremovie'] as String,
      rating: json['rating'] as String,
      image: json['image'] as String,
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
    );

Map<String, dynamic> _$$_DbMovieModelToJson(_$_DbMovieModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'genremovie': instance.genremovie,
      'rating': instance.rating,
      'image': instance.image,
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
    };
