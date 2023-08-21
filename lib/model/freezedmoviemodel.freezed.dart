// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezedmoviemodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DbMovieModel _$DbMovieModelFromJson(Map<String, dynamic> json) {
  return _DbMovieModel.fromJson(json);
}

/// @nodoc
mixin _$DbMovieModel {
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get rating => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DbMovieModelCopyWith<DbMovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DbMovieModelCopyWith<$Res> {
  factory $DbMovieModelCopyWith(
          DbMovieModel value, $Res Function(DbMovieModel) then) =
      _$DbMovieModelCopyWithImpl<$Res, DbMovieModel>;
  @useResult
  $Res call(
      {String name,
      String title,
      String rating,
      String image,
      String id,
      DateTime date});
}

/// @nodoc
class _$DbMovieModelCopyWithImpl<$Res, $Val extends DbMovieModel>
    implements $DbMovieModelCopyWith<$Res> {
  _$DbMovieModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? title = null,
    Object? rating = null,
    Object? image = null,
    Object? id = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DbMovieModelCopyWith<$Res>
    implements $DbMovieModelCopyWith<$Res> {
  factory _$$_DbMovieModelCopyWith(
          _$_DbMovieModel value, $Res Function(_$_DbMovieModel) then) =
      __$$_DbMovieModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String title,
      String rating,
      String image,
      String id,
      DateTime date});
}

/// @nodoc
class __$$_DbMovieModelCopyWithImpl<$Res>
    extends _$DbMovieModelCopyWithImpl<$Res, _$_DbMovieModel>
    implements _$$_DbMovieModelCopyWith<$Res> {
  __$$_DbMovieModelCopyWithImpl(
      _$_DbMovieModel _value, $Res Function(_$_DbMovieModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? title = null,
    Object? rating = null,
    Object? image = null,
    Object? id = null,
    Object? date = null,
  }) {
    return _then(_$_DbMovieModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DbMovieModel implements _DbMovieModel {
  _$_DbMovieModel(
      {required this.name,
      required this.title,
      required this.rating,
      required this.image,
      required this.id,
      required this.date});

  factory _$_DbMovieModel.fromJson(Map<String, dynamic> json) =>
      _$$_DbMovieModelFromJson(json);

  @override
  final String name;
  @override
  final String title;
  @override
  final String rating;
  @override
  final String image;
  @override
  final String id;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'DbMovieModel(name: $name, title: $title, rating: $rating, image: $image, id: $id, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DbMovieModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, title, rating, image, id, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DbMovieModelCopyWith<_$_DbMovieModel> get copyWith =>
      __$$_DbMovieModelCopyWithImpl<_$_DbMovieModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DbMovieModelToJson(
      this,
    );
  }
}

abstract class _DbMovieModel implements DbMovieModel {
  factory _DbMovieModel(
      {required final String name,
      required final String title,
      required final String rating,
      required final String image,
      required final String id,
      required final DateTime date}) = _$_DbMovieModel;

  factory _DbMovieModel.fromJson(Map<String, dynamic> json) =
      _$_DbMovieModel.fromJson;

  @override
  String get name;
  @override
  String get title;
  @override
  String get rating;
  @override
  String get image;
  @override
  String get id;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$_DbMovieModelCopyWith<_$_DbMovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}
