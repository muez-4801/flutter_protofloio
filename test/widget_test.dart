import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_protofloio/main.dart';
import 'package:flutter_protofloio/utils/constants.dart';

void main() {
  testWidgets('Portfolio loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text(PortfolioData.name), findsOneWidget);
  });
}
