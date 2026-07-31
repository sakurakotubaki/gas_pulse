// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gold_price_tick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoldPriceTick {

 String get symbol; double get price; int get timestamp; GoldPriceStatus get status;
/// Create a copy of GoldPriceTick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoldPriceTickCopyWith<GoldPriceTick> get copyWith => _$GoldPriceTickCopyWithImpl<GoldPriceTick>(this as GoldPriceTick, _$identity);

  /// Serializes this GoldPriceTick to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoldPriceTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,price,timestamp,status);

@override
String toString() {
  return 'GoldPriceTick(symbol: $symbol, price: $price, timestamp: $timestamp, status: $status)';
}


}

/// @nodoc
abstract mixin class $GoldPriceTickCopyWith<$Res>  {
  factory $GoldPriceTickCopyWith(GoldPriceTick value, $Res Function(GoldPriceTick) _then) = _$GoldPriceTickCopyWithImpl;
@useResult
$Res call({
 String symbol, double price, int timestamp, GoldPriceStatus status
});




}
/// @nodoc
class _$GoldPriceTickCopyWithImpl<$Res>
    implements $GoldPriceTickCopyWith<$Res> {
  _$GoldPriceTickCopyWithImpl(this._self, this._then);

  final GoldPriceTick _self;
  final $Res Function(GoldPriceTick) _then;

/// Create a copy of GoldPriceTick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? price = null,Object? timestamp = null,Object? status = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoldPriceStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [GoldPriceTick].
extension GoldPriceTickPatterns on GoldPriceTick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoldPriceTick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoldPriceTick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoldPriceTick value)  $default,){
final _that = this;
switch (_that) {
case _GoldPriceTick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoldPriceTick value)?  $default,){
final _that = this;
switch (_that) {
case _GoldPriceTick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  double price,  int timestamp,  GoldPriceStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoldPriceTick() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  double price,  int timestamp,  GoldPriceStatus status)  $default,) {final _that = this;
switch (_that) {
case _GoldPriceTick():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  double price,  int timestamp,  GoldPriceStatus status)?  $default,) {final _that = this;
switch (_that) {
case _GoldPriceTick() when $default != null:
return $default(_that.symbol,_that.price,_that.timestamp,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoldPriceTick extends GoldPriceTick {
  const _GoldPriceTick({required this.symbol, required this.price, required this.timestamp, required this.status}): super._();
  factory _GoldPriceTick.fromJson(Map<String, dynamic> json) => _$GoldPriceTickFromJson(json);

@override final  String symbol;
@override final  double price;
@override final  int timestamp;
@override final  GoldPriceStatus status;

/// Create a copy of GoldPriceTick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoldPriceTickCopyWith<_GoldPriceTick> get copyWith => __$GoldPriceTickCopyWithImpl<_GoldPriceTick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoldPriceTickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoldPriceTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,price,timestamp,status);

@override
String toString() {
  return 'GoldPriceTick(symbol: $symbol, price: $price, timestamp: $timestamp, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GoldPriceTickCopyWith<$Res> implements $GoldPriceTickCopyWith<$Res> {
  factory _$GoldPriceTickCopyWith(_GoldPriceTick value, $Res Function(_GoldPriceTick) _then) = __$GoldPriceTickCopyWithImpl;
@override @useResult
$Res call({
 String symbol, double price, int timestamp, GoldPriceStatus status
});




}
/// @nodoc
class __$GoldPriceTickCopyWithImpl<$Res>
    implements _$GoldPriceTickCopyWith<$Res> {
  __$GoldPriceTickCopyWithImpl(this._self, this._then);

  final _GoldPriceTick _self;
  final $Res Function(_GoldPriceTick) _then;

/// Create a copy of GoldPriceTick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? price = null,Object? timestamp = null,Object? status = null,}) {
  return _then(_GoldPriceTick(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoldPriceStatus,
  ));
}


}

// dart format on
