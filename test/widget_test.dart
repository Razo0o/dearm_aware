import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trycam/WelcomeScreen.dart';
import 'package:trycam/auth/LoginScreen.dart';

void main() {
  testWidgets('WelcomeScreen navigates to LoginScreen on button tap',
      (WidgetTester tester) async {
    // بناء التطبيق مع WelcomeScreen
    await tester.pumpWidget(MaterialApp(home: WelcomeScreen()));

    // الانتظار حتى يتم بناء جميع العناصر
    await tester.pumpAndSettle();

    // التحقق من وجود النصوص في WelcomeScreen
    expect(find.text('ابدأ'), findsOneWidget);

    // الضغط على زر "ابدأ"
    await tester.tap(find.text('ابدأ'));
    await tester.pumpAndSettle();

    // التحقق من وجود LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
