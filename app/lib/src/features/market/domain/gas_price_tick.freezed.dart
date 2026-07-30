// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas_price_tick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GasPriceTick {

 String get symbol; double get price; int get timestamp; PriceStatus get status;
/// Create a copy of GasPriceTick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GasPriceTickCopyWith<GasPriceTick> get copyWith => _$GasPriceTickCopyWithImpl<GasPriceTick>(this as GasPriceTick, _$identity);

  /// Serializes this GasPriceTick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GasPriceTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,price,timestamp,status);

@override
String toString() {
  return 'GasPriceTick(symbol: $symbol, price: $price, timestamp: $timestamp, status: $status)';
}


}

/// @nodoc
abstract mixin class $GasPriceTickCopyWith<$Res>  {
  factory $GasPriceTickCopyWith(GasPriceTick value, $Res Function(GasPriceTick) _then) = _$GasPriceTickCopyWithImpl;
@useResult
$Res call({
 String symbol, double price, int timestamp, PriceStatus status
});




}
/// @nodoc
class _$GasPriceTickCopyWithImpl<$Res>
    implements $GasPriceTickCopyWith<$Res> {
  _$GasPriceTickCopyWithImpl(this._self, this._then);

  final GasPriceTick _self;
  final $Res Function(GasPriceTick) _then;

/// Create a copy of GasPriceTick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? price = null,Object? timestamp = null,Object? status = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PriceStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [GasPriceTick].
extension GasPriceTickPatterns on GasPriceTick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GasPriceTick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GasPriceTick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GasPriceTick value)  $default,){
final _that = this;
switch (_that) {
case _GasPriceTick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GasPriceTick value)?  $default,){
final _that = this;
switch (_that) {
case _GasPriceTick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  double price,  int timestamp,  PriceStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GasPriceTick() when $default != null:
return $default(_that.symbol,_that.price,_that.timestamp,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  double price,  int timestamp,  PriceStatus status)  $default,) {final _that = this;
switch (_that) {
case _GasPriceTick():
return $default(_that.symbol,_that.price,_that.timestamp,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  double price,  int timestamp,  PriceStatus status)?  $default,) {final _that = this;
switch (_that) {
case _GasPriceTick() when $default != null:
return $default(_that.symbol,_that.price,_that.timestamp,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GasPriceTick extends GasPriceTick {
  const _GasPriceTick({required this.symbol, required this.price, required this.timestamp, required this.status}): super._();
  factory _GasPriceTick.fromJson(Map<String, dynamic> json) => _$GasPriceTickFromJson(json);

@override final  String symbol;
@override final  double price;
@override final  int timestamp;
@override final  PriceStatus status;

/// Create a copy of GasPriceTick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GasPriceTickCopyWith<_GasPriceTick> get copyWith => __$GasPriceTickCopyWithImpl<_GasPriceTick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GasPriceTickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GasPriceTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,price,timestamp,status);

@override
String toString() {
  return 'GasPriceTick(symbol: $symbol, price: $price, timestamp: $timestamp, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GasPriceTickCopyWith<$Res> implements $GasPriceTickCopyWith<$Res> {
  factory _$GasPriceTickCopyWith(_GasPriceTick value, $Res Function(_GasPriceTick) _then) = __$GasPriceTickCopyWithImpl;
@override @useResult
$Res call({
 String symbol, double price, int timestamp, PriceStatus status
});




}
/// @nodoc
class __$GasPriceTickCopyWithImpl<$Res>
    implements _$GasPriceTickCopyWith<$Res> {
  __$GasPriceTickCopyWithImpl(this._self, this._then);

  final _GasPriceTick _self;
  final $Res Function(_GasPriceTick) _then;

/// Create a copy of GasPriceTick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? price = null,Object? timestamp = null,Object? status = null,}) {
  return _then(_GasPriceTick(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PriceStatus,
  ));
}


}

// dart format on
