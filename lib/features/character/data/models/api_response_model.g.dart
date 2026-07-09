// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CharacterApiResponseModel _$CharacterApiResponseModelFromJson(
  Map<String, dynamic> json,
) => _CharacterApiResponseModel(
  info: CharacterInfoModel.fromJson(json['info'] as Map<String, dynamic>),
  results: (json['results'] as List<dynamic>)
      .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CharacterApiResponseModelToJson(
  _CharacterApiResponseModel instance,
) => <String, dynamic>{'info': instance.info, 'results': instance.results};

_CharacterInfoModel _$CharacterInfoModelFromJson(Map<String, dynamic> json) =>
    _CharacterInfoModel(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$CharacterInfoModelToJson(_CharacterInfoModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
