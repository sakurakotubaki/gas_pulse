// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stockEndpoint)
final stockEndpointProvider = StockEndpointProvider._();

final class StockEndpointProvider extends $FunctionalProvider<Uri, Uri, Uri>
    with $Provider<Uri> {
  StockEndpointProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockEndpointProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockEndpointHash();

  @$internal
  @override
  $ProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uri create(Ref ref) {
    return stockEndpoint(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uri value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uri>(value),
    );
  }
}

String _$stockEndpointHash() => r'f8686b737213723ed5f23c900fce8ee0f7aea578';

@ProviderFor(stockRepository)
final stockRepositoryProvider = StockRepositoryProvider._();

final class StockRepositoryProvider
    extends
        $FunctionalProvider<StockRepository, StockRepository, StockRepository>
    with $Provider<StockRepository> {
  StockRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockRepositoryHash();

  @$internal
  @override
  $ProviderElement<StockRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StockRepository create(Ref ref) {
    return stockRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StockRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StockRepository>(value),
    );
  }
}

String _$stockRepositoryHash() => r'fe80474115e2cc0006e48bede56fb5f5ee28e5fb';

@ProviderFor(StockFeed)
final stockFeedProvider = StockFeedProvider._();

final class StockFeedProvider
    extends $NotifierProvider<StockFeed, StockFeedState> {
  StockFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockFeedHash();

  @$internal
  @override
  StockFeed create() => StockFeed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StockFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StockFeedState>(value),
    );
  }
}

String _$stockFeedHash() => r'86a18d9bddc602c5f9fe9161ff3e526c70e08b78';

abstract class _$StockFeed extends $Notifier<StockFeedState> {
  StockFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<StockFeedState, StockFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StockFeedState, StockFeedState>,
              StockFeedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
