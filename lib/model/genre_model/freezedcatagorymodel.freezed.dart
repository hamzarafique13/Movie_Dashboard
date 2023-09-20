// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezedcatagorymodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CatagoryModel _$CatagoryModelFromJson(Map<String, dynamic> json) {
  return _CatagoryModel.fromJson(json);
}

/// @nodoc
mixin _$CatagoryModel {
  String get genre => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatagoryModelCopyWith<CatagoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatagoryModelCopyWith<$Res> {
  factory $CatagoryModelCopyWith(
          CatagoryModel value, $Res Function(CatagoryModel) then) =
      _$CatagoryModelCopyWithImpl<$Res, CatagoryModel>;
  @useResult
  $Res call({String genre, String id});
}

/// @nodoc
class _$CatagoryModelCopyWithImpl<$Res, $Val extends CatagoryModel>
    implements $CatagoryModelCopyWith<$Res> {
  _$CatagoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genre = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CatagoryModelCopyWith<$Res>
    implements $CatagoryModelCopyWith<$Res> {
  factory _$$_CatagoryModelCopyWith(
          _$_CatagoryModel value, $Res Function(_$_CatagoryModel) then) =
      __$$_CatagoryModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String genre, String id});
}

/// @nodoc
class __$$_CatagoryModelCopyWithImpl<$Res>
    extends _$CatagoryModelCopyWithImpl<$Res, _$_CatagoryModel>
    implements _$$_CatagoryModelCopyWith<$Res> {
  __$$_CatagoryModelCopyWithImpl(
      _$_CatagoryModel _value, $Res Function(_$_CatagoryModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genre = null,
    Object? id = null,
  }) {
    return _then(_$_CatagoryModel(
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CatagoryModel implements _CatagoryModel {
  _$_CatagoryModel({required this.genre, required this.id});

  factory _$_CatagoryModel.fromJson(Map<String, dynamic> json) =>
      _$$_CatagoryModelFromJson(json);

  @override
  final String genre;
  @override
  final String id;

  @override
  String toString() {
    return 'CatagoryModel(genre: $genre, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CatagoryModel &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, genre, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CatagoryModelCopyWith<_$_CatagoryModel> get copyWith =>
      __$$_CatagoryModelCopyWithImpl<_$_CatagoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CatagoryModelToJson(
      this,
    );
  }
}

abstract class _CatagoryModel implements CatagoryModel {
  factory _CatagoryModel(
      {required final String genre,
      required final String id}) = _$_CatagoryModel;

  factory _CatagoryModel.fromJson(Map<String, dynamic> json) =
      _$_CatagoryModel.fromJson;

  @override
  String get genre;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_CatagoryModelCopyWith<_$_CatagoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
