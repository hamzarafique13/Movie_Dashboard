import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezedcatagorymodel.freezed.dart';
part 'freezedcatagorymodel.g.dart';

@freezed
class CatagoryModel with _$CatagoryModel {
  // @JsonSerializable(explicitToJson: true)
  factory CatagoryModel({
    required String genre,
    required String id,
  }) = _CatagoryModel;

  factory CatagoryModel.fromJson(Map<String, dynamic> json) =>
      _$CatagoryModelFromJson(json);
}
