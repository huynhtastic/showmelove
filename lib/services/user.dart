import 'dart:io';

import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/models/user.dart';
import 'package:showsomelove/services/storage.dart';
import 'package:showsomelove/utils/contains_test_object.dart';

import 'adapters/firestore.dart';

class UserService {
  static const COLLECTION_NAME = 'users';

  final User user;
  final FirestoreAdapter fsAdapter;
  final StorageService storage;

  UserService(this.user, {FirestoreAdapter fsAdapter, StorageService storage})
      : assert(containsTestObject(fsAdapter),
            'Tests require a mock FirestoreAdapter instance.'),
        assert(containsTestObject(storage),
            'Tests require a mock StorageService instance.'),
        this.fsAdapter = fsAdapter ?? FirestoreAdapter(),
        this.storage = storage ?? StorageService();

  Future<String> createPost(
      String recipientName, String message, File image) async {
    final imageUrl =
        image != null ? await storage.uploadToFirebase(image) : null;
    final newPostID =
        await fsAdapter.createPost(user.uid, recipientName, message, imageUrl);

    return newPostID;
  }

  Stream<List<Post>> get getPosts => fsAdapter.getPosts(user.uid);

  Future<void> updateUserData(String name) async =>
      await fsAdapter.updateUserData(user.uid, name);
}
