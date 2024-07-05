import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_jus_168/main.dart';

void main() {
  testWidgets('MyHomePage widget test', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: MyHomePage(title: 'Test Title')));

    expect(find.text('Test Title'), findsOneWidget);
  });
}
