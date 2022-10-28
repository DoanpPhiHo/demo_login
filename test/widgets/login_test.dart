import 'package:demo_login/pages/pages.dart';
import 'package:demo_login/utils/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('validate email inline error message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));

    final buttonFinder = find.bySubtype<TextButton>();
    final emailErrorFinder = find.text('Maximum length 256 characters');

    await tester.tap(buttonFinder);
    await tester.pump(const Duration(milliseconds: 300)); // add delay
    expect(emailErrorFinder, findsOneWidget);
  });
  testWidgets('validate pass inline error message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));
    final emailWidgetFinder = find.bySubtype<TextFormField>().first;
    await tester.enterText(emailWidgetFinder, 'text@gmail.com');
    final buttonFinder = find.bySubtype<TextButton>();
    final emailErrorFinder =
        find.text('Password must be at least 6 characters');

    await tester.tap(buttonFinder);
    await tester.pump(const Duration(milliseconds: 300)); // add delay
    expect(emailErrorFinder, findsOneWidget);
  });

  testWidgets('validate pass inline error message',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    ));
    final login = find.bySubtype<TextButton>();
    expect(login, findsOneWidget);
    await tester.tap(login);
    // tester.pump(const Duration(seconds: 2)); // add delay
    await tester.pumpAndSettle();
    final emailWidgetFinder = find.bySubtype<TextFormField>().first;
    expect(emailWidgetFinder, findsOneWidget);
    await tester.enterText(emailWidgetFinder, 'hello@example.com');
    final passFinder = find.bySubtype<TextFormField>().last;
    expect(passFinder, findsOneWidget);
    await tester.enterText(passFinder, '123456');
    final buttonFinder = find.bySubtype<TextButton>();

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    final wellcom = find.text('Wellcom');
    expect(wellcom, findsOneWidget);
  });
}
