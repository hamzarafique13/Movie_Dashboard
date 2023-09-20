import 'package:json_annotation/json_annotation.dart';

part 'authormodel.g.dart';

@JsonSerializable()
class AuthorReviews {
  @JsonKey(name: 'avatar_path')
  String? image;
  @JsonKey(name: 'rating')
  double? rating;
  @JsonKey(name: 'name')
  String? name;

  AuthorReviews(
      {required this.image, required this.name, required this.rating});

  factory AuthorReviews.fromJson(Map<String, dynamic> map) =>
      _$AuthorReviewsFromJson(map);
  Map<String, dynamic> toJson() => _$AuthorReviewsToJson(this);
}
