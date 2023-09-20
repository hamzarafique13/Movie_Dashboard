// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviedetailmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieReviews _$MovieReviewsFromJson(Map<String, dynamic> json) => MovieReviews(
      contant: json['content'] as String?,
      author: AuthorReviews.fromJson(
          json['author_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieReviewsToJson(MovieReviews instance) =>
    <String, dynamic>{
      'content': instance.contant,
      'author_details': instance.author.toJson(),
    };
