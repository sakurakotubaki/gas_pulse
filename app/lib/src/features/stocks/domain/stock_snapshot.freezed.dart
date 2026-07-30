// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockQuote {

 String get symbol; String get name; double get price; double get change; double get changePercent; StockDirection get direction;
/// Create a copy of StockQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockQuoteCopyWith<StockQuote> get copyWith => _$StockQuoteCopyWithImpl<StockQuote>(this as StockQuote, _$identity);

  /// Serializes this StockQuote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockQuote&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,price,change,changePercent,direction);

@override
String toString() {
  return 'StockQuote(symbol: $symbol, name: $name, price: $price, change: $change, changePercent: $changePercent, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $StockQuoteCopyWith<$Res>  {
  factory $StockQuoteCopyWith(StockQuote value, $Res Function(StockQuote) _then) = _$StockQuoteCopyWithImpl;
@useResult
$Res call({
 String symbol, String name, double price, double change, double changePercent, StockDirection direction
});




}
/// @nodoc
class _$StockQuoteCopyWithImpl<$Res>
    implements $StockQuoteCopyWith<$Res> {
  _$StockQuoteCopyWithImpl(this._self, this._then);

  final StockQuote _self;
  final $Res Function(StockQuote) _then;

/// Create a copy of StockQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? name = null,Object? price = null,Object? change = null,Object? changePercent = null,Object? direction = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as StockDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [StockQuote].
extension StockQuotePatterns on StockQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockQuote value)  $default,){
final _that = this;
switch (_that) {
case _StockQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockQuote value)?  $default,){
final _that = this;
switch (_that) {
case _StockQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String name,  double price,  double change,  double changePercent,  StockDirection direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockQuote() when $default != null:
return $default(_that.symbol,_that.name,_that.price,_that.change,_that.changePercent,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String name,  double price,  double change,  double changePercent,  StockDirection direction)  $default,) {final _that = this;
switch (_that) {
case _StockQuote():
return $default(_that.symbol,_that.name,_that.price,_that.change,_that.changePercent,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String name,  double price,  double change,  double changePercent,  StockDirection direction)?  $default,) {final _that = this;
switch (_that) {
case _StockQuote() when $default != null:
return $default(_that.symbol,_that.name,_that.price,_that.change,_that.changePercent,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockQuote extends StockQuote {
  const _StockQuote({required this.symbol, required this.name, required this.price, required this.change, required this.changePercent, required this.direction}): super._();
  factory _StockQuote.fromJson(Map<String, dynamic> json) => _$StockQuoteFromJson(json);

@override final  String symbol;
@override final  String name;
@override final  double price;
@override final  double change;
@override final  double changePercent;
@override final  StockDirection direction;

/// Create a copy of StockQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockQuoteCopyWith<_StockQuote> get copyWith => __$StockQuoteCopyWithImpl<_StockQuote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockQuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockQuote&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,price,change,changePercent,direction);

@override
String toString() {
  return 'StockQuote(symbol: $symbol, name: $name, price: $price, change: $change, changePercent: $changePercent, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$StockQuoteCopyWith<$Res> implements $StockQuoteCopyWith<$Res> {
  factory _$StockQuoteCopyWith(_StockQuote value, $Res Function(_StockQuote) _then) = __$StockQuoteCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String name, double price, double change, double changePercent, StockDirection direction
});




}
/// @nodoc
class __$StockQuoteCopyWithImpl<$Res>
    implements _$StockQuoteCopyWith<$Res> {
  __$StockQuoteCopyWithImpl(this._self, this._then);

  final _StockQuote _self;
  final $Res Function(_StockQuote) _then;

/// Create a copy of StockQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? name = null,Object? price = null,Object? change = null,Object? changePercent = null,Object? direction = null,}) {
  return _then(_StockQuote(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as StockDirection,
  ));
}


}


/// @nodoc
mixin _$StockSnapshot {

 String get market; int get timestamp; List<StockQuote> get quotes;
/// Create a copy of StockSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockSnapshotCopyWith<StockSnapshot> get copyWith => _$StockSnapshotCopyWithImpl<StockSnapshot>(this as StockSnapshot, _$identity);

  /// Serializes this StockSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockSnapshot&&(identical(other.market, market) || other.market == market)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.quotes, quotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,market,timestamp,const DeepCollectionEquality().hash(quotes));

@override
String toString() {
  return 'StockSnapshot(market: $market, timestamp: $timestamp, quotes: $quotes)';
}


}

/// @nodoc
abstract mixin class $StockSnapshotCopyWith<$Res>  {
  factory $StockSnapshotCopyWith(StockSnapshot value, $Res Function(StockSnapshot) _then) = _$StockSnapshotCopyWithImpl;
@useResult
$Res call({
 String market, int timestamp, List<StockQuote> quotes
});




}
/// @nodoc
class _$StockSnapshotCopyWithImpl<$Res>
    implements $StockSnapshotCopyWith<$Res> {
  _$StockSnapshotCopyWithImpl(this._self, this._then);

  final StockSnapshot _self;
  final $Res Function(StockSnapshot) _then;

/// Create a copy of StockSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? market = null,Object? timestamp = null,Object? quotes = null,}) {
  return _then(_self.copyWith(
market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<StockQuote>,
  ));
}

}


/// Adds pattern-matching-related methods to [StockSnapshot].
extension StockSnapshotPatterns on StockSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _StockSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _StockSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String market,  int timestamp,  List<StockQuote> quotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockSnapshot() when $default != null:
return $default(_that.market,_that.timestamp,_that.quotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String market,  int timestamp,  List<StockQuote> quotes)  $default,) {final _that = this;
switch (_that) {
case _StockSnapshot():
return $default(_that.market,_that.timestamp,_that.quotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String market,  int timestamp,  List<StockQuote> quotes)?  $default,) {final _that = this;
switch (_that) {
case _StockSnapshot() when $default != null:
return $default(_that.market,_that.timestamp,_that.quotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockSnapshot extends StockSnapshot {
  const _StockSnapshot({required this.market, required this.timestamp, required final  List<StockQuote> quotes}): _quotes = quotes,super._();
  factory _StockSnapshot.fromJson(Map<String, dynamic> json) => _$StockSnapshotFromJson(json);

@override final  String market;
@override final  int timestamp;
 final  List<StockQuote> _quotes;
@override List<StockQuote> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}


/// Create a copy of StockSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockSnapshotCopyWith<_StockSnapshot> get copyWith => __$StockSnapshotCopyWithImpl<_StockSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockSnapshot&&(identical(other.market, market) || other.market == market)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._quotes, _quotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,market,timestamp,const DeepCollectionEquality().hash(_quotes));

@override
String toString() {
  return 'StockSnapshot(market: $market, timestamp: $timestamp, quotes: $quotes)';
}


}

/// @nodoc
abstract mixin class _$StockSnapshotCopyWith<$Res> implements $StockSnapshotCopyWith<$Res> {
  factory _$StockSnapshotCopyWith(_StockSnapshot value, $Res Function(_StockSnapshot) _then) = __$StockSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String market, int timestamp, List<StockQuote> quotes
});




}
/// @nodoc
class __$StockSnapshotCopyWithImpl<$Res>
    implements _$StockSnapshotCopyWith<$Res> {
  __$StockSnapshotCopyWithImpl(this._self, this._then);

  final _StockSnapshot _self;
  final $Res Function(_StockSnapshot) _then;

/// Create a copy of StockSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? market = null,Object? timestamp = null,Object? quotes = null,}) {
  return _then(_StockSnapshot(
market: null == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<StockQuote>,
  ));
}


}

// dart format on
