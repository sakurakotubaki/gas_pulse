// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketState {

 MarketConnectionStatus get connectionStatus; List<GasPriceTick> get ticks; String? get errorMessage;
/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketStateCopyWith<MarketState> get copyWith => _$MarketStateCopyWithImpl<MarketState>(this as MarketState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other.ticks, ticks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(ticks),errorMessage);

@override
String toString() {
  return 'MarketState(connectionStatus: $connectionStatus, ticks: $ticks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $MarketStateCopyWith<$Res>  {
  factory $MarketStateCopyWith(MarketState value, $Res Function(MarketState) _then) = _$MarketStateCopyWithImpl;
@useResult
$Res call({
 MarketConnectionStatus connectionStatus, List<GasPriceTick> ticks, String? errorMessage
});




}
/// @nodoc
class _$MarketStateCopyWithImpl<$Res>
    implements $MarketStateCopyWith<$Res> {
  _$MarketStateCopyWithImpl(this._self, this._then);

  final MarketState _self;
  final $Res Function(MarketState) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionStatus = null,Object? ticks = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as MarketConnectionStatus,ticks: null == ticks ? _self.ticks : ticks // ignore: cast_nullable_to_non_nullable
as List<GasPriceTick>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketState].
extension MarketStatePatterns on MarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketState value)  $default,){
final _that = this;
switch (_that) {
case _MarketState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketState value)?  $default,){
final _that = this;
switch (_that) {
case _MarketState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MarketConnectionStatus connectionStatus,  List<GasPriceTick> ticks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MarketConnectionStatus connectionStatus,  List<GasPriceTick> ticks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _MarketState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MarketConnectionStatus connectionStatus,  List<GasPriceTick> ticks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _MarketState() when $default != null:
return $default(_that.connectionStatus,_that.ticks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MarketState extends MarketState {
  const _MarketState({this.connectionStatus = MarketConnectionStatus.connecting, final  List<GasPriceTick> ticks = const <GasPriceTick>[], this.errorMessage}): _ticks = ticks,super._();


@override@JsonKey() final  MarketConnectionStatus connectionStatus;
 final  List<GasPriceTick> _ticks;
@override@JsonKey() List<GasPriceTick> get ticks {
  if (_ticks is EqualUnmodifiableListView) return _ticks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ticks);
}

@override final  String? errorMessage;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketStateCopyWith<_MarketState> get copyWith => __$MarketStateCopyWithImpl<_MarketState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&const DeepCollectionEquality().equals(other._ticks, _ticks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,const DeepCollectionEquality().hash(_ticks),errorMessage);

@override
String toString() {
  return 'MarketState(connectionStatus: $connectionStatus, ticks: $ticks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$MarketStateCopyWith<$Res> implements $MarketStateCopyWith<$Res> {
  factory _$MarketStateCopyWith(_MarketState value, $Res Function(_MarketState) _then) = __$MarketStateCopyWithImpl;
@override @useResult
$Res call({
 MarketConnectionStatus connectionStatus, List<GasPriceTick> ticks, String? errorMessage
});




}
/// @nodoc
class __$MarketStateCopyWithImpl<$Res>
    implements _$MarketStateCopyWith<$Res> {
  __$MarketStateCopyWithImpl(this._self, this._then);

  final _MarketState _self;
  final $Res Function(_MarketState) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionStatus = null,Object? ticks = null,Object? errorMessage = freezed,}) {
  return _then(_MarketState(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as MarketConnectionStatus,ticks: null == ticks ? _self._ticks : ticks // ignore: cast_nullable_to_non_nullable
as List<GasPriceTick>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
