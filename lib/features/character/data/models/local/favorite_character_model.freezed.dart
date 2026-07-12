// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_character_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteCharacterModel {

 int get id; String get name; String get status; String get species; String get type; String get gender; String get imageUrl; String get originName; String get locationName; int? get originLocationId; int? get currentLocationId; int get episodeCount; List<int> get episodeIds;
/// Create a copy of FavoriteCharacterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteCharacterModelCopyWith<FavoriteCharacterModel> get copyWith => _$FavoriteCharacterModelCopyWithImpl<FavoriteCharacterModel>(this as FavoriteCharacterModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteCharacterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.species, species) || other.species == species)&&(identical(other.type, type) || other.type == type)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.originName, originName) || other.originName == originName)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.originLocationId, originLocationId) || other.originLocationId == originLocationId)&&(identical(other.currentLocationId, currentLocationId) || other.currentLocationId == currentLocationId)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&const DeepCollectionEquality().equals(other.episodeIds, episodeIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,status,species,type,gender,imageUrl,originName,locationName,originLocationId,currentLocationId,episodeCount,const DeepCollectionEquality().hash(episodeIds));

@override
String toString() {
  return 'FavoriteCharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, imageUrl: $imageUrl, originName: $originName, locationName: $locationName, originLocationId: $originLocationId, currentLocationId: $currentLocationId, episodeCount: $episodeCount, episodeIds: $episodeIds)';
}


}

/// @nodoc
abstract mixin class $FavoriteCharacterModelCopyWith<$Res>  {
  factory $FavoriteCharacterModelCopyWith(FavoriteCharacterModel value, $Res Function(FavoriteCharacterModel) _then) = _$FavoriteCharacterModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String status, String species, String type, String gender, String imageUrl, String originName, String locationName, int? originLocationId, int? currentLocationId, int episodeCount, List<int> episodeIds
});




}
/// @nodoc
class _$FavoriteCharacterModelCopyWithImpl<$Res>
    implements $FavoriteCharacterModelCopyWith<$Res> {
  _$FavoriteCharacterModelCopyWithImpl(this._self, this._then);

  final FavoriteCharacterModel _self;
  final $Res Function(FavoriteCharacterModel) _then;

/// Create a copy of FavoriteCharacterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? species = null,Object? type = null,Object? gender = null,Object? imageUrl = null,Object? originName = null,Object? locationName = null,Object? originLocationId = freezed,Object? currentLocationId = freezed,Object? episodeCount = null,Object? episodeIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,originName: null == originName ? _self.originName : originName // ignore: cast_nullable_to_non_nullable
as String,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,originLocationId: freezed == originLocationId ? _self.originLocationId : originLocationId // ignore: cast_nullable_to_non_nullable
as int?,currentLocationId: freezed == currentLocationId ? _self.currentLocationId : currentLocationId // ignore: cast_nullable_to_non_nullable
as int?,episodeCount: null == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int,episodeIds: null == episodeIds ? _self.episodeIds : episodeIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteCharacterModel].
extension FavoriteCharacterModelPatterns on FavoriteCharacterModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteCharacterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteCharacterModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteCharacterModel value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteCharacterModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteCharacterModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteCharacterModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String species,  String type,  String gender,  String imageUrl,  String originName,  String locationName,  int? originLocationId,  int? currentLocationId,  int episodeCount,  List<int> episodeIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteCharacterModel() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.imageUrl,_that.originName,_that.locationName,_that.originLocationId,_that.currentLocationId,_that.episodeCount,_that.episodeIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String species,  String type,  String gender,  String imageUrl,  String originName,  String locationName,  int? originLocationId,  int? currentLocationId,  int episodeCount,  List<int> episodeIds)  $default,) {final _that = this;
switch (_that) {
case _FavoriteCharacterModel():
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.imageUrl,_that.originName,_that.locationName,_that.originLocationId,_that.currentLocationId,_that.episodeCount,_that.episodeIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String status,  String species,  String type,  String gender,  String imageUrl,  String originName,  String locationName,  int? originLocationId,  int? currentLocationId,  int episodeCount,  List<int> episodeIds)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteCharacterModel() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.imageUrl,_that.originName,_that.locationName,_that.originLocationId,_that.currentLocationId,_that.episodeCount,_that.episodeIds);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteCharacterModel implements FavoriteCharacterModel {
  const _FavoriteCharacterModel({required this.id, required this.name, required this.status, required this.species, required this.type, required this.gender, required this.imageUrl, required this.originName, required this.locationName, required this.originLocationId, required this.currentLocationId, required this.episodeCount, required final  List<int> episodeIds}): _episodeIds = episodeIds;
  

@override final  int id;
@override final  String name;
@override final  String status;
@override final  String species;
@override final  String type;
@override final  String gender;
@override final  String imageUrl;
@override final  String originName;
@override final  String locationName;
@override final  int? originLocationId;
@override final  int? currentLocationId;
@override final  int episodeCount;
 final  List<int> _episodeIds;
@override List<int> get episodeIds {
  if (_episodeIds is EqualUnmodifiableListView) return _episodeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodeIds);
}


/// Create a copy of FavoriteCharacterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteCharacterModelCopyWith<_FavoriteCharacterModel> get copyWith => __$FavoriteCharacterModelCopyWithImpl<_FavoriteCharacterModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteCharacterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.species, species) || other.species == species)&&(identical(other.type, type) || other.type == type)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.originName, originName) || other.originName == originName)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.originLocationId, originLocationId) || other.originLocationId == originLocationId)&&(identical(other.currentLocationId, currentLocationId) || other.currentLocationId == currentLocationId)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&const DeepCollectionEquality().equals(other._episodeIds, _episodeIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,status,species,type,gender,imageUrl,originName,locationName,originLocationId,currentLocationId,episodeCount,const DeepCollectionEquality().hash(_episodeIds));

@override
String toString() {
  return 'FavoriteCharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, imageUrl: $imageUrl, originName: $originName, locationName: $locationName, originLocationId: $originLocationId, currentLocationId: $currentLocationId, episodeCount: $episodeCount, episodeIds: $episodeIds)';
}


}

/// @nodoc
abstract mixin class _$FavoriteCharacterModelCopyWith<$Res> implements $FavoriteCharacterModelCopyWith<$Res> {
  factory _$FavoriteCharacterModelCopyWith(_FavoriteCharacterModel value, $Res Function(_FavoriteCharacterModel) _then) = __$FavoriteCharacterModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String status, String species, String type, String gender, String imageUrl, String originName, String locationName, int? originLocationId, int? currentLocationId, int episodeCount, List<int> episodeIds
});




}
/// @nodoc
class __$FavoriteCharacterModelCopyWithImpl<$Res>
    implements _$FavoriteCharacterModelCopyWith<$Res> {
  __$FavoriteCharacterModelCopyWithImpl(this._self, this._then);

  final _FavoriteCharacterModel _self;
  final $Res Function(_FavoriteCharacterModel) _then;

/// Create a copy of FavoriteCharacterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? species = null,Object? type = null,Object? gender = null,Object? imageUrl = null,Object? originName = null,Object? locationName = null,Object? originLocationId = freezed,Object? currentLocationId = freezed,Object? episodeCount = null,Object? episodeIds = null,}) {
  return _then(_FavoriteCharacterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,originName: null == originName ? _self.originName : originName // ignore: cast_nullable_to_non_nullable
as String,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,originLocationId: freezed == originLocationId ? _self.originLocationId : originLocationId // ignore: cast_nullable_to_non_nullable
as int?,currentLocationId: freezed == currentLocationId ? _self.currentLocationId : currentLocationId // ignore: cast_nullable_to_non_nullable
as int?,episodeCount: null == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int,episodeIds: null == episodeIds ? _self._episodeIds : episodeIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
