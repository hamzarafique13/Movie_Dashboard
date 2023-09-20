// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authormodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorReviews _$AuthorReviewsFromJson(Map<String, dynamic> json) =>
    AuthorReviews(
      image: json['avatar_path'] as String?,
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AuthorReviewsToJson(AuthorReviews instance) =>
    <String, dynamic>{
      'avatar_path': instance.image,
      'rating': instance.rating,
      'name': instance.name,
    };
