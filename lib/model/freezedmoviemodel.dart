import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezedmoviemodel.freezed.dart';
part 'freezedmoviemodel.g.dart';

@freezed
class DbMovieModel with _$DbMovieModel {
  @JsonSerializable(explicitToJson: true)
  factory DbMovieModel({
    required String name,
    required String title,
    required String rating,
    required String image,
    required String id,
    required DateTime date,
  }) = _DbMovieModel;

  factory DbMovieModel.fromJson(Map<String, dynamic> json) =>
      _$DbMovieModelFromJson(json);
}
