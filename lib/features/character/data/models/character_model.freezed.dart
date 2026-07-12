// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharacterModel {

 int get id; String get name; String get status; String get species; String get type; String get gender; String get image; CharacterOriginModel get origin; CharacterLocationModel get location; List<String> get episode;
/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterModelCopyWith<CharacterModel> get copyWith => _$CharacterModelCopyWithImpl<CharacterModel>(this as CharacterModel, _$identity);

  /// Serializes this CharacterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.species, species) || other.species == species)&&(identical(other.type, type) || other.type == type)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.image, image) || other.image == image)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.episode, episode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,species,type,gender,image,origin,location,const DeepCollectionEquality().hash(episode));

@override
String toString() {
  return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, image: $image, origin: $origin, location: $location, episode: $episode)';
}


}

/// @nodoc
abstract mixin class $CharacterModelCopyWith<$Res>  {
  factory $CharacterModelCopyWith(CharacterModel value, $Res Function(CharacterModel) _then) = _$CharacterModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String status, String species, String type, String gender, String image, CharacterOriginModel origin, CharacterLocationModel location, List<String> episode
});


$CharacterOriginModelCopyWith<$Res> get origin;$CharacterLocationModelCopyWith<$Res> get location;

}
/// @nodoc
class _$CharacterModelCopyWithImpl<$Res>
    implements $CharacterModelCopyWith<$Res> {
  _$CharacterModelCopyWithImpl(this._self, this._then);

  final CharacterModel _self;
  final $Res Function(CharacterModel) _then;

/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? species = null,Object? type = null,Object? gender = null,Object? image = null,Object? origin = null,Object? location = null,Object? episode = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as CharacterOriginModel,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CharacterLocationModel,episode: null == episode ? _self.episode : episode // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterOriginModelCopyWith<$Res> get origin {
  
  return $CharacterOriginModelCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterLocationModelCopyWith<$Res> get location {
  
  return $CharacterLocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [CharacterModel].
extension CharacterModelPatterns on CharacterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String species,  String type,  String gender,  String image,  CharacterOriginModel origin,  CharacterLocationModel location,  List<String> episode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.image,_that.origin,_that.location,_that.episode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String species,  String type,  String gender,  String image,  CharacterOriginModel origin,  CharacterLocationModel location,  List<String> episode)  $default,) {final _that = this;
switch (_that) {
case _CharacterModel():
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.image,_that.origin,_that.location,_that.episode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String status,  String species,  String type,  String gender,  String image,  CharacterOriginModel origin,  CharacterLocationModel location,  List<String> episode)?  $default,) {final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.image,_that.origin,_that.location,_that.episode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterModel implements CharacterModel {
  const _CharacterModel({required this.id, required this.name, required this.status, required this.species, required this.type, required this.gender, required this.image, required this.origin, required this.location, required final  List<String> episode}): _episode = episode;
  factory _CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String status;
@override final  String species;
@override final  String type;
@override final  String gender;
@override final  String image;
@override final  CharacterOriginModel origin;
@override final  CharacterLocationModel location;
 final  List<String> _episode;
@override List<String> get episode {
  if (_episode is EqualUnmodifiableListView) return _episode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episode);
}


/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterModelCopyWith<_CharacterModel> get copyWith => __$CharacterModelCopyWithImpl<_CharacterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.species, species) || other.species == species)&&(identical(other.type, type) || other.type == type)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.image, image) || other.image == image)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._episode, _episode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,species,type,gender,image,origin,location,const DeepCollectionEquality().hash(_episode));

@override
String toString() {
  return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, image: $image, origin: $origin, location: $location, episode: $episode)';
}


}

/// @nodoc
abstract mixin class _$CharacterModelCopyWith<$Res> implements $CharacterModelCopyWith<$Res> {
  factory _$CharacterModelCopyWith(_CharacterModel value, $Res Function(_CharacterModel) _then) = __$CharacterModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String status, String species, String type, String gender, String image, CharacterOriginModel origin, CharacterLocationModel location, List<String> episode
});


@override $CharacterOriginModelCopyWith<$Res> get origin;@override $CharacterLocationModelCopyWith<$Res> get location;

}
/// @nodoc
class __$CharacterModelCopyWithImpl<$Res>
    implements _$CharacterModelCopyWith<$Res> {
  __$CharacterModelCopyWithImpl(this._self, this._then);

  final _CharacterModel _self;
  final $Res Function(_CharacterModel) _then;

/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? species = null,Object? type = null,Object? gender = null,Object? image = null,Object? origin = null,Object? location = null,Object? episode = null,}) {
  return _then(_CharacterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as CharacterOriginModel,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CharacterLocationModel,episode: null == episode ? _self._episode : episode // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterOriginModelCopyWith<$Res> get origin {
  
  return $CharacterOriginModelCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterLocationModelCopyWith<$Res> get location {
  
  return $CharacterLocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$CharacterOriginModel {

 String get name; String get url;
/// Create a copy of CharacterOriginModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterOriginModelCopyWith<CharacterOriginModel> get copyWith => _$CharacterOriginModelCopyWithImpl<CharacterOriginModel>(this as CharacterOriginModel, _$identity);

  /// Serializes this CharacterOriginModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterOriginModel&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'CharacterOriginModel(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $CharacterOriginModelCopyWith<$Res>  {
  factory $CharacterOriginModelCopyWith(CharacterOriginModel value, $Res Function(CharacterOriginModel) _then) = _$CharacterOriginModelCopyWithImpl;
@useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class _$CharacterOriginModelCopyWithImpl<$Res>
    implements $CharacterOriginModelCopyWith<$Res> {
  _$CharacterOriginModelCopyWithImpl(this._self, this._then);

  final CharacterOriginModel _self;
  final $Res Function(CharacterOriginModel) _then;

/// Create a copy of CharacterOriginModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterOriginModel].
extension CharacterOriginModelPatterns on CharacterOriginModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterOriginModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterOriginModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterOriginModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterOriginModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterOriginModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterOriginModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterOriginModel() when $default != null:
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url)  $default,) {final _that = this;
switch (_that) {
case _CharacterOriginModel():
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url)?  $default,) {final _that = this;
switch (_that) {
case _CharacterOriginModel() when $default != null:
return $default(_that.name,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterOriginModel implements CharacterOriginModel {
  const _CharacterOriginModel({required this.name, required this.url});
  factory _CharacterOriginModel.fromJson(Map<String, dynamic> json) => _$CharacterOriginModelFromJson(json);

@override final  String name;
@override final  String url;

/// Create a copy of CharacterOriginModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterOriginModelCopyWith<_CharacterOriginModel> get copyWith => __$CharacterOriginModelCopyWithImpl<_CharacterOriginModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterOriginModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterOriginModel&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'CharacterOriginModel(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class _$CharacterOriginModelCopyWith<$Res> implements $CharacterOriginModelCopyWith<$Res> {
  factory _$CharacterOriginModelCopyWith(_CharacterOriginModel value, $Res Function(_CharacterOriginModel) _then) = __$CharacterOriginModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class __$CharacterOriginModelCopyWithImpl<$Res>
    implements _$CharacterOriginModelCopyWith<$Res> {
  __$CharacterOriginModelCopyWithImpl(this._self, this._then);

  final _CharacterOriginModel _self;
  final $Res Function(_CharacterOriginModel) _then;

/// Create a copy of CharacterOriginModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,}) {
  return _then(_CharacterOriginModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CharacterLocationModel {

 String get name; String get url;
/// Create a copy of CharacterLocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterLocationModelCopyWith<CharacterLocationModel> get copyWith => _$CharacterLocationModelCopyWithImpl<CharacterLocationModel>(this as CharacterLocationModel, _$identity);

  /// Serializes this CharacterLocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterLocationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'CharacterLocationModel(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $CharacterLocationModelCopyWith<$Res>  {
  factory $CharacterLocationModelCopyWith(CharacterLocationModel value, $Res Function(CharacterLocationModel) _then) = _$CharacterLocationModelCopyWithImpl;
@useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class _$CharacterLocationModelCopyWithImpl<$Res>
    implements $CharacterLocationModelCopyWith<$Res> {
  _$CharacterLocationModelCopyWithImpl(this._self, this._then);

  final CharacterLocationModel _self;
  final $Res Function(CharacterLocationModel) _then;

/// Create a copy of CharacterLocationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterLocationModel].
extension CharacterLocationModelPatterns on CharacterLocationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterLocationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterLocationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterLocationModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterLocationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterLocationModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterLocationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterLocationModel() when $default != null:
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url)  $default,) {final _that = this;
switch (_that) {
case _CharacterLocationModel():
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url)?  $default,) {final _that = this;
switch (_that) {
case _CharacterLocationModel() when $default != null:
return $default(_that.name,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterLocationModel implements CharacterLocationModel {
  const _CharacterLocationModel({required this.name, required this.url});
  factory _CharacterLocationModel.fromJson(Map<String, dynamic> json) => _$CharacterLocationModelFromJson(json);

@override final  String name;
@override final  String url;

/// Create a copy of CharacterLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterLocationModelCopyWith<_CharacterLocationModel> get copyWith => __$CharacterLocationModelCopyWithImpl<_CharacterLocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterLocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterLocationModel&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'CharacterLocationModel(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class _$CharacterLocationModelCopyWith<$Res> implements $CharacterLocationModelCopyWith<$Res> {
  factory _$CharacterLocationModelCopyWith(_CharacterLocationModel value, $Res Function(_CharacterLocationModel) _then) = __$CharacterLocationModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class __$CharacterLocationModelCopyWithImpl<$Res>
    implements _$CharacterLocationModelCopyWith<$Res> {
  __$CharacterLocationModelCopyWithImpl(this._self, this._then);

  final _CharacterLocationModel _self;
  final $Res Function(_CharacterLocationModel) _then;

/// Create a copy of CharacterLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,}) {
  return _then(_CharacterLocationModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
