import 'dart:convert';

import 'package:gas_pulse/src/features/oil/domain/oil_price_tick.dart';
import 'package:http/http.dart' as http;

class OilHistoryResult {
  const OilHistoryResult({required this.ticks, required this.cacheStatus});

  final List<OilPriceTick> ticks;
  final String cacheStatus;
}

class OilHistoryRepository {
  OilHistoryRepository({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  Future<OilHistoryResult> fetch(Uri endpoint) async {
    final response = await _client.get(endpoint);
    if (response.statusCode != 200) {
      throw Exception('Oil history request failed (${response.statusCode})');
    }
    final body = jsonDecode(response.body) as List<dynamic>;
    return OilHistoryResult(
      ticks: body
          .map((item) => OilPriceTick.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      cacheStatus: response.headers['x-cache']?.toUpperCase() ?? 'UNKNOWN',
    );
  }

  void close() => _client.close();
}
