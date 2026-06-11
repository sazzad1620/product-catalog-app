import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog_app/core/widgets/loading_view.dart';

void main() {
  testWidgets('LoadingView shows progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: LoadingView(message: 'Loading products...')),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading products...'), findsOneWidget);
  });
}
