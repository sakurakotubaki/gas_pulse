// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oil_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OilState {

 OilConnectionStatus get connectionStatus; List<OilPriceTick> get ticks; String? get errorMessage;
/// Create a copy of OilState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OilStateCopyWith<OilState> get copyWith => _$OilStateCopyWithImpl<OilState>(this as OilState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OilState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other.ticks, ticks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(ticks),errorMessage);

@override
String toString() {
  return 'OilState(connectionStatus: $connectionStatus, ticks: $ticks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $OilStateCopyWith<$Res>  {
  factory $OilStateCopyWith(OilState value, $Res Function(OilState) _then) = _$OilStateCopyWithImpl;
@useResult
$Res call({
 OilConnectionStatus connectionStatus, List<OilPriceTick> ticks, String? errorMessage
});




}
/// @nodoc
class _$OilStateCopyWithImpl<$Res>
    implements $OilStateCopyWith<$Res> {
  _$OilStateCopyWithImpl(this._self, this._then);

  final OilState _self;
  final $Res Function(OilState) _then;

/// Create a copy of OilState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionStatus = null,Object? ticks = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as OilConnectionStatus,ticks: null == ticks ? _self.ticks : ticks // ignore: cast_nullable_to_non_nullable
as List<OilPriceTick>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OilState].
extension OilStatePatterns on OilState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OilState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OilState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OilState value)  $default,){
final _that = this;
switch (_that) {
case _OilState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OilState value)?  $default,){
final _that = this;
switch (_that) {
case _OilState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OilConnectionStatus connectionStatus,  List<OilPriceTick> ticks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OilState() when $default != null:
return $default(_that.connectionStatus,_that.ticks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OilConnectionStatus connectionStatus,  List<OilPriceTick> ticks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _OilState():
return $default(_that.connectionStatus,_that.ticks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OilConnectionStatus connectionStatus,  List<OilPriceTick> ticks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _OilState() when $default != null:
return $default(_that.connectionStatus,_that.ticks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OilState extends OilState {
  const _OilState({this.connectionStatus = OilConnectionStatus.connecting, final  List<OilPriceTick> ticks = const <OilPriceTick>[], this.errorMessage}): _ticks = ticks,super._();
  

@override@JsonKey() final  OilConnectionStatus connectionStatus;
 final  List<OilPriceTick> _ticks;
@override@JsonKey() List<OilPriceTick> get ticks {
  if (_ticks is EqualUnmodifiableListView) return _ticks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ticks);
}

@override final  String? errorMessage;

/// Create a copy of OilState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OilStateCopyWith<_OilState> get copyWith => __$OilStateCopyWithImpl<_OilState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OilState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other._ticks, _ticks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(_ticks),errorMessage);

@override
String toString() {
  return 'OilState(connectionStatus: $connectionStatus, ticks: $ticks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$OilStateCopyWith<$Res> implements $OilStateCopyWith<$Res> {
  factory _$OilStateCopyWith(_OilState value, $Res Function(_OilState) _then) = __$OilStateCopyWithImpl;
@override @useResult
$Res call({
 OilConnectionStatus connectionStatus, List<OilPriceTick> ticks, String? errorMessage
});




}
/// @nodoc
class __$OilStateCopyWithImpl<$Res>
    implements _$OilStateCopyWith<$Res> {
  __$OilStateCopyWithImpl(this._self, this._then);

  final _OilState _self;
  final $Res Function(_OilState) _then;

/// Create a copy of OilState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionStatus = null,Object? ticks = null,Object? errorMessage = freezed,}) {
  return _then(_OilState(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as OilConnectionStatus,ticks: null == ticks ? _self._ticks : ticks // ignore: cast_nullable_to_non_nullable
as List<OilPriceTick>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
