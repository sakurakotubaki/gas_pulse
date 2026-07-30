import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_pulse/src/app.dart';

void main() {
  testWidgets('shows the market dashboard while connecting', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: GasPulseApp()));
    await tester.pump();

    expect(find.text('GAS / PULSE'), findsOneWidget);
    expect(find.text('Energy in\nmotion.'), findsOneWidget);
    expect(find.text('CONNECTING'), findsOneWidget);
  });
}
