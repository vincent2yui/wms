import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wms/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login test', () {
    testWidgets('long press on the company logo', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final Finder companyLogo = find.byKey(const Key('CompanyLogoKey'));

      await tester.longPress(companyLogo);

      await tester.pumpAndSettle();

      expect(find.text('Embedded Demo'), findsOneWidget);
      expect(find.text('Development'), findsOneWidget);
      expect(find.text('Production'), findsOneWidget);
    });
  });
}
