import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/services/authentication.dart';
import 'package:test/test.dart';

class MockAuth extends Mock implements FirebaseAuth {}

class MockResult extends Mock implements AuthResult {
  final MockFbUser user;

  MockResult({this.user});
}

class MockFbUser extends Mock implements FirebaseUser {}

final getIt = GetIt.instance;

void main() {
  setUp(() {
    getIt.registerFactory<FirebaseAuth>(() => MockAuth());
  });

  tearDown(() {
    getIt.reset();
  });

  test('should initialize', () {
    final auth = AuthenticationService();
    expect(auth, isA<AuthenticationService>());
  });

  group('signInUser', () {
    test('should login given valid creds', () async {
      final testCred = 'testuser';
      final mockAuth = MockAuth();
      when(
        mockAuth.signInWithEmailAndPassword(
          email: argThat(equals(testCred), named: 'email'),
          password: argThat(equals(testCred), named: 'password'),
        ),
      ).thenAnswer(
        (_) async => MockResult(
          user: MockFbUser(),
        ),
      );

      getIt.unregister<FirebaseAuth>();
      getIt.registerSingleton<FirebaseAuth>(mockAuth);
      final mockAuthService = AuthenticationService();
      getIt.registerSingleton<AuthenticationService>(mockAuthService);

      final actual = await mockAuthService.signInUser(testCred, testCred);
      expect(actual, isNull);
    });

    test('should return error code given unregistered email', () async {
      final invalidCred = 'testuser';
      final expectedErrorCode = 'ERROR_USER_NOT_FOUND';
      final mockAuth = MockAuth();
      when(
        mockAuth.signInWithEmailAndPassword(
          email: argThat(equals(invalidCred), named: 'email'),
          password: argThat(equals(invalidCred), named: 'password'),
        ),
      ).thenThrow(PlatformException(code: expectedErrorCode));

      getIt.unregister<FirebaseAuth>();
      getIt.registerSingleton<FirebaseAuth>(mockAuth);
      final mockAuthService = AuthenticationService();
      getIt.registerSingleton<AuthenticationService>(mockAuthService);

      final actual = await mockAuthService.signInUser(invalidCred, invalidCred);
      final expected = equals(expectedErrorCode);
      expect(actual, expected);
    });
  });
}
