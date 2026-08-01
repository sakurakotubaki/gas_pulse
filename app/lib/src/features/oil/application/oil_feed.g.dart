// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oil_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(oilEndpoint)
final oilEndpointProvider = OilEndpointProvider._();

final class OilEndpointProvider extends $FunctionalProvider<Uri, Uri, Uri>
    with $Provider<Uri> {
  OilEndpointProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oilEndpointProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oilEndpointHash();

  @$internal
  @override
  $ProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uri create(Ref ref) {
    return oilEndpoint(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uri value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uri>(value),
    );
  }
}

String _$oilEndpointHash() => r'ab7e94d0c3e2419dfd98811141c28bc0471d3eb0';

@ProviderFor(RedisCacheEnabled)
final redisCacheEnabledProvider = RedisCacheEnabledProvider._();

final class RedisCacheEnabledProvider
    extends $NotifierProvider<RedisCacheEnabled, bool> {
  RedisCacheEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redisCacheEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redisCacheEnabledHash();

  @$internal
  @override
  RedisCacheEnabled create() => RedisCacheEnabled();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$redisCacheEnabledHash() => r'18154de86896ceb22a35be8a0be4df370522124d';

abstract class _$RedisCacheEnabled extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(oilPriceRepository)
final oilPriceRepositoryProvider = OilPriceRepositoryProvider._();

final class OilPriceRepositoryProvider
    extends
        $FunctionalProvider<
          OilPriceRepository,
          OilPriceRepository,
          OilPriceRepository
        >
    with $Provider<OilPriceRepository> {
  OilPriceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oilPriceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oilPriceRepositoryHash();

  @$internal
  @override
  $ProviderElement<OilPriceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OilPriceRepository create(Ref ref) {
    return oilPriceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OilPriceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OilPriceRepository>(value),
    );
  }
}

String _$oilPriceRepositoryHash() =>
    r'fcb5d6d82dadaf34b7b58bee045650f2ae0ca571';

@ProviderFor(oilHistoryRepository)
final oilHistoryRepositoryProvider = OilHistoryRepositoryProvider._();

final class OilHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          OilHistoryRepository,
          OilHistoryRepository,
          OilHistoryRepository
        >
    with $Provider<OilHistoryRepository> {
  OilHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oilHistoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oilHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<OilHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OilHistoryRepository create(Ref ref) {
    return oilHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OilHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OilHistoryRepository>(value),
    );
  }
}

String _$oilHistoryRepositoryHash() =>
    r'a09347a79dd236c1376f8029910f269317c4f0ed';

@ProviderFor(oilHistory)
final oilHistoryProvider = OilHistoryProvider._();

final class OilHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<OilHistoryResult>,
          OilHistoryResult,
          FutureOr<OilHistoryResult>
        >
    with $FutureModifier<OilHistoryResult>, $FutureProvider<OilHistoryResult> {
  OilHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oilHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oilHistoryHash();

  @$internal
  @override
  $FutureProviderElement<OilHistoryResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OilHistoryResult> create(Ref ref) {
    return oilHistory(ref);
  }
}

String _$oilHistoryHash() => r'28ade2bfaa970db62305c12cb8d7de421d0b9b27';

@ProviderFor(OilFeed)
final oilFeedProvider = OilFeedProvider._();

final class OilFeedProvider extends $NotifierProvider<OilFeed, OilState> {
  OilFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oilFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oilFeedHash();

  @$internal
  @override
  OilFeed create() => OilFeed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OilState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OilState>(value),
    );
  }
}

String _$oilFeedHash() => r'aaa26a7f3e6ad7434fc0811ab3f2b82f5415b695';

abstract class _$OilFeed extends $Notifier<OilState> {
  OilState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<OilState, OilState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OilState, OilState>,
              OilState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(OilPositions)
final oilPositionsProvider = OilPositionsProvider._();

final class OilPositionsProvider
    extends $NotifierProvider<OilPositions, List<OilPosition>> {
  OilPositionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oilPositionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oilPositionsHash();

  @$internal
  @override
  OilPositions create() => OilPositions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OilPosition> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OilPosition>>(value),
    );
  }
}

String _$oilPositionsHash() => r'b614dc0d2eaa1ba43c0e66e84e419b67dae42561';

abstract class _$OilPositions extends $Notifier<List<OilPosition>> {
  List<OilPosition> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<OilPosition>, List<OilPosition>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<OilPosition>, List<OilPosition>>,
              List<OilPosition>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
