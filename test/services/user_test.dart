import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:showsomelove/models/user.dart';
import 'package:showsomelove/services/adapters/firestore.dart';
import 'package:showsomelove/services/storage.dart';
import 'package:showsomelove/services/user.dart';
import 'package:test/test.dart';

class _File extends Mock implements File {}

class _FirestoreAdapter extends Mock implements FirestoreAdapter {}

class _StorageService extends Mock implements StorageService {}

class _User extends Mock implements User {}

main() {
  test('should initialize', () {
    final actual = UserService(
      _User(),
      fsAdapter: _FirestoreAdapter(),
      storage: _StorageService(),
    );
    expect(actual, isNotNull);
  });

  group('createPost', () {
    test('should create post given non-null input', () async {
      final imageUrl =
          'https://google.com/firebase/services/storage/path/to/image.jpg';
      final testImage = _File();
      final _storageService = _StorageService();
      when(_storageService.uploadToFirebase(testImage))
          .thenAnswer((_) async => imageUrl);

      final recipientName = 'recipientName';
      final message = 'message';

      final expected = 'newPostID';

      final _firestoreAdapter = _FirestoreAdapter();
      when(_firestoreAdapter.createPost(any, recipientName, message, imageUrl))
          .thenAnswer((_) async => expected);

      final userService = UserService(
        _User(),
        fsAdapter: _firestoreAdapter,
        storage: _storageService,
      );
      final actual =
          await userService.createPost(recipientName, message, testImage);

      expect(actual, equals(expected));
    });

    test('should create post given null image', () async {
      final _storageService = _StorageService();
      when(_storageService.uploadToFirebase(null))
          .thenThrow(Exception('A null slipped to uploadToFirebase'));

      final recipientName = 'recipientName';
      final message = 'message';

      final expected = 'newPostID';

      final _firestoreAdapter = _FirestoreAdapter();
      when(_firestoreAdapter.createPost(any, recipientName, message, null))
          .thenAnswer((_) async => expected);

      final userService = UserService(
        _User(),
        fsAdapter: _firestoreAdapter,
        storage: _storageService,
      );
      final actual = await userService.createPost(recipientName, message, null);

      expect(actual, equals(expected));
    });
  });
}
