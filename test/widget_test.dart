// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:companion_core/main.dart';

void main() {
  testWidgets('App loads and navigation works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CompAnIonApp());

    // Check for onboarding or main screen
    expect(find.byType(CompAnIonApp), findsOneWidget);

    // If onboarding is shown, tap through it
    if (find.text('Welcome to CompAnIon!').evaluate().isNotEmpty) {
      // Go through onboarding steps
      for (var i = 0; i < 5; i++) {
        await tester.tap(find.text('Next').first);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.text('Start').first);
      await tester.pumpAndSettle();
    }

    // Now, main screen should be visible
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Drawer), findsOneWidget);

    // Check navigation drawer works
    await tester.tap(find.byIcon(Icons.menu).first);
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsWidgets);

    // Tap Remember Me
    await tester.tap(find.widgetWithText(ListTile, 'Remember Me'));
    await tester.pumpAndSettle();
    expect(find.text('Remember Me'), findsWidgets);

    // Tap Settings
    await tester.tap(find.byIcon(Icons.menu).first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsWidgets);
  });
}
