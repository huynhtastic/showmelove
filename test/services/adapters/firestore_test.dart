import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/services/adapters/firestore.dart';
import 'package:test/test.dart';

class _Firestore extends Mock implements Firestore {}

main() {
  test('should initialize', () {
    final actual = FirestoreAdapter(firestore: _Firestore());
    expect(actual, isNotNull);
  });
}
