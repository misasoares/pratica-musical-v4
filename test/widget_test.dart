import 'package:flutter_test/flutter_test.dart';
import 'package:pratica_musical/main.dart';

void main() {
  testWidgets('Smoke test smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GuitarMasterApp());

    // Verify that our smoke test title is present.
    expect(find.text('Smoke Test'), findsOneWidget);
  });
}
