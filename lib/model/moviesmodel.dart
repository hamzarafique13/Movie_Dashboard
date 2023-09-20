import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_app_use_riverpod/provider/treading_movie_provider.dart';

part 'moviesmodel.g.dart';

@collection
@JsonSerializable()
class MovieModel {
  Id get isarId => fastHash(Uuid);
  @Index(type: IndexType.value, unique: true, replace: true)
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'id')
  int id;
  String Uuid;
  @JsonKey(name: 'poster_path')
  String? moviesurl;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'vote_average')
  double? rating;
  @JsonKey(name: 'release_date')
  String? releasedate;
  @JsonKey(name: 'backdrop_path')
  String? backdropurl;

  MovieModel(
      {required this.moviesurl,
      this.backdropurl,
      required this.rating,
      required this.overview,
      required this.releasedate,
      required this.Uuid,
      required this.title,
      required this.id});

  factory MovieModel.fromJson(Map<String, dynamic> map, String uuid) =>
      _$MovieModelFromJson(map, uuid);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  @override
  int get hashCode {
    return id.hashCode ^
        moviesurl.hashCode ^
        title.hashCode ^
        rating.hashCode ^
        overview.hashCode ^
        releasedate.hashCode ^
        backdropurl.hashCode;
  }

  @override
  bool operator ==(other) {
    return other is MovieModel &&
        id == other.id &&
        moviesurl == other.moviesurl &&
        title == other.title &&
        rating == other.rating &&
        overview == other.overview &&
        releasedate == other.releasedate &&
        backdropurl == other.backdropurl;
  }

  @override
  String toString() {
    return 'MovieModel(title: $title, id: $id, Uuid: $Uuid, moviesurl: $moviesurl, overview: $overview, rating: $rating, releasedate: $releasedate, backdropurl: $backdropurl)';
  }
}
