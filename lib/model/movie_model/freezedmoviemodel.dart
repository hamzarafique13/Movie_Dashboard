import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezedmoviemodel.freezed.dart';
part 'freezedmoviemodel.g.dart';

@freezed
class DbMovieModel with _$DbMovieModel {
  factory DbMovieModel({
    required String name,
    required String genremovie,
    required String rating,
    required String image,
    required String id,
    required DateTime date,
    required String time,
  }) = _DbMovieModel;

  factory DbMovieModel.fromJson(Map<String, dynamic> json) =>
      _$DbMovieModelFromJson(json);
}
