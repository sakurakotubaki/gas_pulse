import 'dart:convert';

import 'package:gas_pulse/src/features/gold/domain/gold_price_tick.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GoldPriceRepository {
  WebSocketChannel? _channel;

  Stream<GoldPriceTick> watch(Uri endpoint) async* {
    await close();
    final channel = WebSocketChannel.connect(endpoint);
    _channel = channel;
    await channel.ready;
    yield* channel.stream.map((event) {
      final json = jsonDecode(event as String) as Map<String, dynamic>;
      return GoldPriceTick.fromJson(json);
    });
  }

  Future<void> close() async {
    final channel = _channel;
    _channel = null;
    await channel?.sink.close();
  }
}
