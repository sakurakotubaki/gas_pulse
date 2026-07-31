// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_feed.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goldEndpoint)
final goldEndpointProvider = GoldEndpointProvider._();

final class GoldEndpointProvider extends $FunctionalProvider<Uri, Uri, Uri>
    with $Provider<Uri> {
  GoldEndpointProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goldEndpointProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goldEndpointHash();

  @$internal
  @override
  $ProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uri create(Ref ref) {
    return goldEndpoint(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uri value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uri>(value),
    );
  }
}

String _$goldEndpointHash() => r'b40e807f4a85615bafb13f827275d28a725a80fc';

@ProviderFor(goldPriceRepository)
final goldPriceRepositoryProvider = GoldPriceRepositoryProvider._();

final class GoldPriceRepositoryProvider
    extends
        $FunctionalProvider<
          GoldPriceRepository,
          GoldPriceRepository,
          GoldPriceRepository
        >
    with $Provider<GoldPriceRepository> {
  GoldPriceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goldPriceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goldPriceRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoldPriceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoldPriceRepository create(Ref ref) {
    return goldPriceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoldPriceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoldPriceRepository>(value),
    );
  }
}

String _$goldPriceRepositoryHash() =>
    r'03e73edff502bb9f72d41663d32644c44d5205f7';

@ProviderFor(GoldFeed)
final goldFeedProvider = GoldFeedProvider._();

final class GoldFeedProvider extends $NotifierProvider<GoldFeed, GoldState> {
  GoldFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goldFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goldFeedHash();

  @$internal
  @override
  GoldFeed create() => GoldFeed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoldState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoldState>(value),
    );
  }
}

String _$goldFeedHash() => r'52f91897e0b0f52e45f6b2f54f15e4731b358f95';

abstract class _$GoldFeed extends $Notifier<GoldState> {
  GoldState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GoldState, GoldState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoldState, GoldState>,
              GoldState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
