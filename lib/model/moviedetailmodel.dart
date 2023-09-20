import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app_use_riverpod/model/authormodel.dart';

part 'moviedetailmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieReviews {
  @JsonKey(name: 'content')
  String? contant;
  @JsonKey(name: 'author_details')
  AuthorReviews author;

  MovieReviews({required this.contant, required this.author});

  factory MovieReviews.fromJson(Map<String, dynamic> map) =>
      _$MovieReviewsFromJson(map);
  Map<String, dynamic> toJson() => _$MovieReviewsToJson(this);
}
