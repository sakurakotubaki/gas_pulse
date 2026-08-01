// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oil_price_tick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OilPriceTick {

 String get symbol; double get price; int get timestamp; OilPriceStatus get status;
/// Create a copy of OilPriceTick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OilPriceTickCopyWith<OilPriceTick> get copyWith => _$OilPriceTickCopyWithImpl<OilPriceTick>(this as OilPriceTick, _$identity);

  /// Serializes this OilPriceTick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OilPriceTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,price,timestamp,status);

@override
String toString() {
  return 'OilPriceTick(symbol: $symbol, price: $price, timestamp: $timestamp, status: $status)';
}


}

/// @nodoc
abstract mixin class $OilPriceTickCopyWith<$Res>  {
  factory $OilPriceTickCopyWith(OilPriceTick value, $Res Function(OilPriceTick) _then) = _$OilPriceTickCopyWithImpl;
@useResult
$Res call({
 String symbol, double price, int timestamp, OilPriceStatus status
});




}
/// @nodoc
class _$OilPriceTickCopyWithImpl<$Res>
    implements $OilPriceTickCopyWith<$Res> {
  _$OilPriceTickCopyWithImpl(this._self, this._then);

  final OilPriceTick _self;
  final $Res Function(OilPriceTick) _then;

/// Create a copy of OilPriceTick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? price = null,Object? timestamp = null,Object? status = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OilPriceStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [OilPriceTick].
extension OilPriceTickPatterns on OilPriceTick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OilPriceTick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OilPriceTick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OilPriceTick value)  $default,){
final _that = this;
switch (_that) {
case _OilPriceTick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OilPriceTick value)?  $default,){
final _that = this;
switch (_that) {
case _OilPriceTick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  double price,  int timestamp,  OilPriceStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OilPriceTick() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  double price,  int timestamp,  OilPriceStatus status)  $default,) {final _that = this;
switch (_that) {
case _OilPriceTick():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  double price,  int timestamp,  OilPriceStatus status)?  $default,) {final _that = this;
switch (_that) {
case _OilPriceTick() when $default != null:
return $default(_that.symbol,_that.price,_that.timestamp,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OilPriceTick extends OilPriceTick {
  const _OilPriceTick({required this.symbol, required this.price, required this.timestamp, required this.status}): super._();
  factory _OilPriceTick.fromJson(Map<String, dynamic> json) => _$OilPriceTickFromJson(json);

@override final  String symbol;
@override final  double price;
@override final  int timestamp;
@override final  OilPriceStatus status;

/// Create a copy of OilPriceTick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OilPriceTickCopyWith<_OilPriceTick> get copyWith => __$OilPriceTickCopyWithImpl<_OilPriceTick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OilPriceTickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OilPriceTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,price,timestamp,status);

@override
String toString() {
  return 'OilPriceTick(symbol: $symbol, price: $price, timestamp: $timestamp, status: $status)';
}


}

/// @nodoc
abstract mixin class _$OilPriceTickCopyWith<$Res> implements $OilPriceTickCopyWith<$Res> {
  factory _$OilPriceTickCopyWith(_OilPriceTick value, $Res Function(_OilPriceTick) _then) = __$OilPriceTickCopyWithImpl;
@override @useResult
$Res call({
 String symbol, double price, int timestamp, OilPriceStatus status
});




}
/// @nodoc
class __$OilPriceTickCopyWithImpl<$Res>
    implements _$OilPriceTickCopyWith<$Res> {
  __$OilPriceTickCopyWithImpl(this._self, this._then);

  final _OilPriceTick _self;
  final $Res Function(_OilPriceTick) _then;

/// Create a copy of OilPriceTick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? price = null,Object? timestamp = null,Object? status = null,}) {
  return _then(_OilPriceTick(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OilPriceStatus,
  ));
}


}

// dart format on
