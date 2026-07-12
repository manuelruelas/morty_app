import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morty_app/features/character/data/models/character_model.dart';

part 'api_response_model.freezed.dart';
part 'api_response_model.g.dart';

@freezed
abstract class CharacterApiResponseModel with _$CharacterApiResponseModel {
  const factory CharacterApiResponseModel({
    required final CharacterInfoModel info,
    required final List<CharacterModel> results,
  }) = _CharacterApiResponseModel;

  factory CharacterApiResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$CharacterApiResponseModelFromJson(json);
}

@freezed
abstract class CharacterInfoModel with _$CharacterInfoModel {
  const factory CharacterInfoModel({
    required final int count,
    required final int pages,
    final String? next,
    final String? prev,
  }) = _CharacterInfoModel;

  factory CharacterInfoModel.fromJson(final Map<String, dynamic> json) =>
      _$CharacterInfoModelFromJson(json);
}
