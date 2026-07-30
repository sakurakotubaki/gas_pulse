// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gasPriceEndpoint)
final gasPriceEndpointProvider = GasPriceEndpointProvider._();

final class GasPriceEndpointProvider extends $FunctionalProvider<Uri, Uri, Uri>
    with $Provider<Uri> {
  GasPriceEndpointProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gasPriceEndpointProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gasPriceEndpointHash();

  @$internal
  @override
  $ProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uri create(Ref ref) {
    return gasPriceEndpoint(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uri value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uri>(value),
    );
  }
}

String _$gasPriceEndpointHash() => r'76dde64dbf610d53ca4434d74a94809a609418e5';

@ProviderFor(gasPriceRepository)
final gasPriceRepositoryProvider = GasPriceRepositoryProvider._();

final class GasPriceRepositoryProvider
    extends
        $FunctionalProvider<
          GasPriceRepository,
          GasPriceRepository,
          GasPriceRepository
        >
    with $Provider<GasPriceRepository> {
  GasPriceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gasPriceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gasPriceRepositoryHash();

  @$internal
  @override
  $ProviderElement<GasPriceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GasPriceRepository create(Ref ref) {
    return gasPriceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GasPriceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GasPriceRepository>(value),
    );
  }
}

String _$gasPriceRepositoryHash() =>
    r'b1d028994c36134f50932b2bd3953a2f17402b95';

@ProviderFor(MarketFeed)
final marketFeedProvider = MarketFeedProvider._();

final class MarketFeedProvider
    extends $NotifierProvider<MarketFeed, MarketState> {
  MarketFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketFeedHash();

  @$internal
  @override
  MarketFeed create() => MarketFeed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarketState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarketState>(value),
    );
  }
}

String _$marketFeedHash() => r'cd70a19ec571db7198a333b0823d2b0862086cb4';

abstract class _$MarketFeed extends $Notifier<MarketState> {
  MarketState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MarketState, MarketState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MarketState, MarketState>,
              MarketState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
