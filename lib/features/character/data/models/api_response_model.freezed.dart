// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharacterApiResponseModel {

 CharacterInfoModel get info; List<CharacterModel> get results;
/// Create a copy of CharacterApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterApiResponseModelCopyWith<CharacterApiResponseModel> get copyWith => _$CharacterApiResponseModelCopyWithImpl<CharacterApiResponseModel>(this as CharacterApiResponseModel, _$identity);

  /// Serializes this CharacterApiResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterApiResponseModel&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'CharacterApiResponseModel(info: $info, results: $results)';
}


}

/// @nodoc
abstract mixin class $CharacterApiResponseModelCopyWith<$Res>  {
  factory $CharacterApiResponseModelCopyWith(CharacterApiResponseModel value, $Res Function(CharacterApiResponseModel) _then) = _$CharacterApiResponseModelCopyWithImpl;
@useResult
$Res call({
 CharacterInfoModel info, List<CharacterModel> results
});


$CharacterInfoModelCopyWith<$Res> get info;

}
/// @nodoc
class _$CharacterApiResponseModelCopyWithImpl<$Res>
    implements $CharacterApiResponseModelCopyWith<$Res> {
  _$CharacterApiResponseModelCopyWithImpl(this._self, this._then);

  final CharacterApiResponseModel _self;
  final $Res Function(CharacterApiResponseModel) _then;

/// Create a copy of CharacterApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? results = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as CharacterInfoModel,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<CharacterModel>,
  ));
}
/// Create a copy of CharacterApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterInfoModelCopyWith<$Res> get info {
  
  return $CharacterInfoModelCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [CharacterApiResponseModel].
extension CharacterApiResponseModelPatterns on CharacterApiResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterApiResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterApiResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterApiResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterApiResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterApiResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterApiResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CharacterInfoModel info,  List<CharacterModel> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterApiResponseModel() when $default != null:
return $default(_that.info,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CharacterInfoModel info,  List<CharacterModel> results)  $default,) {final _that = this;
switch (_that) {
case _CharacterApiResponseModel():
return $default(_that.info,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CharacterInfoModel info,  List<CharacterModel> results)?  $default,) {final _that = this;
switch (_that) {
case _CharacterApiResponseModel() when $default != null:
return $default(_that.info,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterApiResponseModel implements CharacterApiResponseModel {
  const _CharacterApiResponseModel({required this.info, required final  List<CharacterModel> results}): _results = results;
  factory _CharacterApiResponseModel.fromJson(Map<String, dynamic> json) => _$CharacterApiResponseModelFromJson(json);

@override final  CharacterInfoModel info;
 final  List<CharacterModel> _results;
@override List<CharacterModel> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of CharacterApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterApiResponseModelCopyWith<_CharacterApiResponseModel> get copyWith => __$CharacterApiResponseModelCopyWithImpl<_CharacterApiResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterApiResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterApiResponseModel&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'CharacterApiResponseModel(info: $info, results: $results)';
}


}

/// @nodoc
abstract mixin class _$CharacterApiResponseModelCopyWith<$Res> implements $CharacterApiResponseModelCopyWith<$Res> {
  factory _$CharacterApiResponseModelCopyWith(_CharacterApiResponseModel value, $Res Function(_CharacterApiResponseModel) _then) = __$CharacterApiResponseModelCopyWithImpl;
@override @useResult
$Res call({
 CharacterInfoModel info, List<CharacterModel> results
});


@override $CharacterInfoModelCopyWith<$Res> get info;

}
/// @nodoc
class __$CharacterApiResponseModelCopyWithImpl<$Res>
    implements _$CharacterApiResponseModelCopyWith<$Res> {
  __$CharacterApiResponseModelCopyWithImpl(this._self, this._then);

  final _CharacterApiResponseModel _self;
  final $Res Function(_CharacterApiResponseModel) _then;

/// Create a copy of CharacterApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? results = null,}) {
  return _then(_CharacterApiResponseModel(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as CharacterInfoModel,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<CharacterModel>,
  ));
}

/// Create a copy of CharacterApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CharacterInfoModelCopyWith<$Res> get info {
  
  return $CharacterInfoModelCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// @nodoc
mixin _$CharacterInfoModel {

 int get count; int get pages; String? get next; String? get prev;
/// Create a copy of CharacterInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterInfoModelCopyWith<CharacterInfoModel> get copyWith => _$CharacterInfoModelCopyWithImpl<CharacterInfoModel>(this as CharacterInfoModel, _$identity);

  /// Serializes this CharacterInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterInfoModel&&(identical(other.count, count) || other.count == count)&&(identical(other.pages, pages) || other.pages == pages)&&(identical(other.next, next) || other.next == next)&&(identical(other.prev, prev) || other.prev == prev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,pages,next,prev);

@override
String toString() {
  return 'CharacterInfoModel(count: $count, pages: $pages, next: $next, prev: $prev)';
}


}

/// @nodoc
abstract mixin class $CharacterInfoModelCopyWith<$Res>  {
  factory $CharacterInfoModelCopyWith(CharacterInfoModel value, $Res Function(CharacterInfoModel) _then) = _$CharacterInfoModelCopyWithImpl;
@useResult
$Res call({
 int count, int pages, String? next, String? prev
});




}
/// @nodoc
class _$CharacterInfoModelCopyWithImpl<$Res>
    implements $CharacterInfoModelCopyWith<$Res> {
  _$CharacterInfoModelCopyWithImpl(this._self, this._then);

  final CharacterInfoModel _self;
  final $Res Function(CharacterInfoModel) _then;

/// Create a copy of CharacterInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? pages = null,Object? next = freezed,Object? prev = freezed,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,prev: freezed == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterInfoModel].
extension CharacterInfoModelPatterns on CharacterInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int pages,  String? next,  String? prev)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterInfoModel() when $default != null:
return $default(_that.count,_that.pages,_that.next,_that.prev);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int pages,  String? next,  String? prev)  $default,) {final _that = this;
switch (_that) {
case _CharacterInfoModel():
return $default(_that.count,_that.pages,_that.next,_that.prev);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int pages,  String? next,  String? prev)?  $default,) {final _that = this;
switch (_that) {
case _CharacterInfoModel() when $default != null:
return $default(_that.count,_that.pages,_that.next,_that.prev);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterInfoModel implements CharacterInfoModel {
  const _CharacterInfoModel({required this.count, required this.pages, this.next, this.prev});
  factory _CharacterInfoModel.fromJson(Map<String, dynamic> json) => _$CharacterInfoModelFromJson(json);

@override final  int count;
@override final  int pages;
@override final  String? next;
@override final  String? prev;

/// Create a copy of CharacterInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterInfoModelCopyWith<_CharacterInfoModel> get copyWith => __$CharacterInfoModelCopyWithImpl<_CharacterInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterInfoModel&&(identical(other.count, count) || other.count == count)&&(identical(other.pages, pages) || other.pages == pages)&&(identical(other.next, next) || other.next == next)&&(identical(other.prev, prev) || other.prev == prev));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,pages,next,prev);

@override
String toString() {
  return 'CharacterInfoModel(count: $count, pages: $pages, next: $next, prev: $prev)';
}


}

/// @nodoc
abstract mixin class _$CharacterInfoModelCopyWith<$Res> implements $CharacterInfoModelCopyWith<$Res> {
  factory _$CharacterInfoModelCopyWith(_CharacterInfoModel value, $Res Function(_CharacterInfoModel) _then) = __$CharacterInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int count, int pages, String? next, String? prev
});




}
/// @nodoc
class __$CharacterInfoModelCopyWithImpl<$Res>
    implements _$CharacterInfoModelCopyWith<$Res> {
  __$CharacterInfoModelCopyWithImpl(this._self, this._then);

  final _CharacterInfoModel _self;
  final $Res Function(_CharacterInfoModel) _then;

/// Create a copy of CharacterInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? pages = null,Object? next = freezed,Object? prev = freezed,}) {
  return _then(_CharacterInfoModel(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,prev: freezed == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
