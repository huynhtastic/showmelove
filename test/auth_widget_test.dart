import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/auth.dart';
import 'package:showsomelove/pages/app/home/home.dart';
import 'package:showsomelove/pages/authenticate/authenticate.dart';

class UserMock extends Mock implements FirebaseUser {}

class AuthMock extends Mock implements FirebaseAuth {
  final Duration authStateChangedInterval;
  final List authStateChangedValues;

  AuthMock({authStateChangedInterval, authStateChangedValues})
      : this.authStateChangedInterval =
            authStateChangedInterval ?? Duration(milliseconds: 500),
        this.authStateChangedValues = authStateChangedValues ?? [null];

  Stream<UserMock> get onAuthStateChanged async* {
    for (final value in authStateChangedValues) {
      await Future.delayed(authStateChangedInterval);
      yield value;
    }
  }
}

MaterialApp _auth() => MaterialApp(home: Auth());

void main() {
  final getIt = GetIt.I;
  setUp(() {
    getIt.registerFactory<FirebaseAuth>(
      () => AuthMock(),
    );
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets(
    'should show loading widget while waiting for onAuthStateChanged stream',
    (WidgetTester tester) async {
      await tester.pumpWidget(_auth());

      final expected = find.byType(CircularProgressIndicator);
      expect(expected, findsOneWidget);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'should show authenticate widget if unauthorized',
    (WidgetTester tester) async {
      await tester.pumpWidget(_auth());
      await tester.pumpAndSettle();

      final expected = find.byType(Authenticate);
      expect(expected, findsOneWidget);
    },
  );

  testWidgets(
    'should show home widget if authorized',
    (WidgetTester tester) async {
      final authMock = AuthMock(authStateChangedValues: [UserMock()]);
      getIt.unregister<FirebaseAuth>();
      getIt.registerSingleton<FirebaseAuth>(authMock);

      await tester.pumpWidget(_auth());
      await tester.pump(Duration(seconds: 1));

      final expected = find.byType(Home);
      expect(expected, findsOneWidget);
    },
  );
}
