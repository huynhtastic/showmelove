import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/services/authentication.dart';
import 'package:test/test.dart';

class MockAuth extends Mock implements FirebaseAuth {}

class MockResult extends Mock implements AuthResult {}

void main() {
  test('should initialize', () {
    final mockAuth = MockAuth();
    final auth = AuthenticationService(mockAuth);
    expect(auth, isA<AuthenticationService>());
  });

  group('signInUser', () {
    test('should login given valid creds', () async {
      final mockAuth = MockAuth();
      final auth = AuthenticationService(mockAuth);
      final testCred = 'testuser';
      when(mockAuth.signInWithEmailAndPassword(
              email: testCred, password: testCred))
          .thenAnswer((_) async => Future.value());

      final actual = await auth.signInUser(testCred, testCred);
      expect(actual, isNull);
    });

    test('should return error code given unregistered email', () async {
      final expectedErrorCode = 'ERROR_USER_NOT_FOUND';
      final mockAuth = MockAuth();
      final auth = AuthenticationService(mockAuth);
      final invalidCred = 'testuser';
      when(mockAuth.signInWithEmailAndPassword(
              email: invalidCred, password: invalidCred))
          .thenThrow(PlatformException(code: expectedErrorCode));

      final actual = await auth.signInUser(invalidCred, invalidCred);
      final expected = equals(expectedErrorCode);
      expect(actual, expected);
    });
  });
}
