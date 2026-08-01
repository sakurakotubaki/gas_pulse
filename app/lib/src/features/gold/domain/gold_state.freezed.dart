// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gold_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoldState {

 GoldConnectionStatus get connectionStatus; List<GoldPriceTick> get ticks; String? get errorMessage;
/// Create a copy of GoldState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoldStateCopyWith<GoldState> get copyWith => _$GoldStateCopyWithImpl<GoldState>(this as GoldState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoldState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other.ticks, ticks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(ticks),errorMessage);

@override
String toString() {
  return 'GoldState(connectionStatus: $connectionStatus, ticks: $ticks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $GoldStateCopyWith<$Res>  {
  factory $GoldStateCopyWith(GoldState value, $Res Function(GoldState) _then) = _$GoldStateCopyWithImpl;
@useResult
$Res call({
 GoldConnectionStatus connectionStatus, List<GoldPriceTick> ticks, String? errorMessage
});




}
/// @nodoc
class _$GoldStateCopyWithImpl<$Res>
    implements $GoldStateCopyWith<$Res> {
  _$GoldStateCopyWithImpl(this._self, this._then);

  final GoldState _self;
  final $Res Function(GoldState) _then;

/// Create a copy of GoldState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionStatus = null,Object? ticks = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as GoldConnectionStatus,ticks: null == ticks ? _self.ticks : ticks // ignore: cast_nullable_to_non_nullable
as List<GoldPriceTick>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GoldState].
extension GoldStatePatterns on GoldState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoldState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoldState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoldState value)  $default,){
final _that = this;
switch (_that) {
case _GoldState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoldState value)?  $default,){
final _that = this;
switch (_that) {
case _GoldState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GoldConnectionStatus connectionStatus,  List<GoldPriceTick> ticks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoldState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GoldConnectionStatus connectionStatus,  List<GoldPriceTick> ticks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GoldState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GoldConnectionStatus connectionStatus,  List<GoldPriceTick> ticks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GoldState() when $default != null:
return $default(_that.connectionStatus,_that.ticks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GoldState extends GoldState {
  const _GoldState({this.connectionStatus = GoldConnectionStatus.connecting, final  List<GoldPriceTick> ticks = const <GoldPriceTick>[], this.errorMessage}): _ticks = ticks,super._();
  

@override@JsonKey() final  GoldConnectionStatus connectionStatus;
 final  List<GoldPriceTick> _ticks;
@override@JsonKey() List<GoldPriceTick> get ticks {
  if (_ticks is EqualUnmodifiableListView) return _ticks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ticks);
}

@override final  String? errorMessage;

/// Create a copy of GoldState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoldStateCopyWith<_GoldState> get copyWith => __$GoldStateCopyWithImpl<_GoldState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoldState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other._ticks, _ticks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(_ticks),errorMessage);

@override
String toString() {
  return 'GoldState(connectionStatus: $connectionStatus, ticks: $ticks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GoldStateCopyWith<$Res> implements $GoldStateCopyWith<$Res> {
  factory _$GoldStateCopyWith(_GoldState value, $Res Function(_GoldState) _then) = __$GoldStateCopyWithImpl;
@override @useResult
$Res call({
 GoldConnectionStatus connectionStatus, List<GoldPriceTick> ticks, String? errorMessage
});




}
/// @nodoc
class __$GoldStateCopyWithImpl<$Res>
    implements _$GoldStateCopyWith<$Res> {
  __$GoldStateCopyWithImpl(this._self, this._then);

  final _GoldState _self;
  final $Res Function(_GoldState) _then;

/// Create a copy of GoldState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionStatus = null,Object? ticks = null,Object? errorMessage = freezed,}) {
  return _then(_GoldState(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as GoldConnectionStatus,ticks: null == ticks ? _self._ticks : ticks // ignore: cast_nullable_to_non_nullable
as List<GoldPriceTick>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
