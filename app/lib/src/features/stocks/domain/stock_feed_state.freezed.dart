// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockFeedState {

 StockConnectionStatus get connectionStatus; StockSnapshot? get snapshot; String? get errorMessage;
/// Create a copy of StockFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockFeedStateCopyWith<StockFeedState> get copyWith => _$StockFeedStateCopyWithImpl<StockFeedState>(this as StockFeedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockFeedState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,snapshot,errorMessage);

@override
String toString() {
  return 'StockFeedState(connectionStatus: $connectionStatus, snapshot: $snapshot, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StockFeedStateCopyWith<$Res>  {
  factory $StockFeedStateCopyWith(StockFeedState value, $Res Function(StockFeedState) _then) = _$StockFeedStateCopyWithImpl;
@useResult
$Res call({
 StockConnectionStatus connectionStatus, StockSnapshot? snapshot, String? errorMessage
});


$StockSnapshotCopyWith<$Res>? get snapshot;

}
/// @nodoc
class _$StockFeedStateCopyWithImpl<$Res>
    implements $StockFeedStateCopyWith<$Res> {
  _$StockFeedStateCopyWithImpl(this._self, this._then);

  final StockFeedState _self;
  final $Res Function(StockFeedState) _then;

/// Create a copy of StockFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionStatus = null,Object? snapshot = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as StockConnectionStatus,snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as StockSnapshot?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StockFeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockSnapshotCopyWith<$Res>? get snapshot {
    if (_self.snapshot == null) {
    return null;
  }

  return $StockSnapshotCopyWith<$Res>(_self.snapshot!, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockFeedState].
extension StockFeedStatePatterns on StockFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockFeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockFeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockFeedState value)  $default,){
final _that = this;
switch (_that) {
case _StockFeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockFeedState value)?  $default,){
final _that = this;
switch (_that) {
case _StockFeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StockConnectionStatus connectionStatus,  StockSnapshot? snapshot,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockFeedState() when $default != null:
return $default(_that.connectionStatus,_that.snapshot,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StockConnectionStatus connectionStatus,  StockSnapshot? snapshot,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _StockFeedState():
return $default(_that.connectionStatus,_that.snapshot,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StockConnectionStatus connectionStatus,  StockSnapshot? snapshot,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StockFeedState() when $default != null:
return $default(_that.connectionStatus,_that.snapshot,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StockFeedState implements StockFeedState {
  const _StockFeedState({this.connectionStatus = StockConnectionStatus.connecting, this.snapshot, this.errorMessage});


@override@JsonKey() final  StockConnectionStatus connectionStatus;
@override final  StockSnapshot? snapshot;
@override final  String? errorMessage;

/// Create a copy of StockFeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockFeedStateCopyWith<_StockFeedState> get copyWith => __$StockFeedStateCopyWithImpl<_StockFeedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockFeedState&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,connectionStatus,snapshot,errorMessage);

@override
String toString() {
  return 'StockFeedState(connectionStatus: $connectionStatus, snapshot: $snapshot, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StockFeedStateCopyWith<$Res> implements $StockFeedStateCopyWith<$Res> {
  factory _$StockFeedStateCopyWith(_StockFeedState value, $Res Function(_StockFeedState) _then) = __$StockFeedStateCopyWithImpl;
@override @useResult
$Res call({
 StockConnectionStatus connectionStatus, StockSnapshot? snapshot, String? errorMessage
});


@override $StockSnapshotCopyWith<$Res>? get snapshot;

}
/// @nodoc
class __$StockFeedStateCopyWithImpl<$Res>
    implements _$StockFeedStateCopyWith<$Res> {
  __$StockFeedStateCopyWithImpl(this._self, this._then);

  final _StockFeedState _self;
  final $Res Function(_StockFeedState) _then;

/// Create a copy of StockFeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionStatus = null,Object? snapshot = freezed,Object? errorMessage = freezed,}) {
  return _then(_StockFeedState(
connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as StockConnectionStatus,snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as StockSnapshot?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StockFeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockSnapshotCopyWith<$Res>? get snapshot {
    if (_self.snapshot == null) {
    return null;
  }

  return $StockSnapshotCopyWith<$Res>(_self.snapshot!, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}

// dart format on
