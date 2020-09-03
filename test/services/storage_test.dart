import 'package:firebase_storage/firebase_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/services/storage.dart';
import 'package:test/test.dart';

class _FirebaseStorage extends Mock implements FirebaseStorage {}

main() {
  test('should initialize', () {
    final actual = new StorageService(fbStorage: _FirebaseStorage());
    expect(actual, isNotNull);
  });
}
