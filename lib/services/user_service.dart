import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  static const COLLECTION_NAME = 'users';
  static const POSTS_COLLECTION_NAME = 'posts';

  final User user;
  final DocumentReference userDoc;
  final storage = FirebaseStorage.instance;

  UserService(this.user)
      : this.userDoc =
            Firestore.instance.collection(COLLECTION_NAME).document(user.uid);

  Future<void> updateUserData(String name) async {
    await userDoc.setData({
      'name': name,
    }, merge: true);
  }

  Future createPost(String recipient, String message, File image) async {
    final imageUrl = await _uploadImage(image: image, fileName: 'test');
    final newPost = await userDoc.collection(POSTS_COLLECTION_NAME).add({
      'recipient': recipient,
      'message': message,
      'imageUrl': imageUrl,
    });

    print(newPost);
  }

  Future<String> _uploadImage({
    @required File image,
    @required String fileName,
  }) async {
    var imageFileName =
        fileName + DateTime.now().millisecondsSinceEpoch.toString();

    final storageRef = this.storage.ref().child(imageFileName);
    final uploadTask = storageRef.putFile(image);
    final storageSnapshot = await uploadTask.onComplete;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      return downloadUrl.toString();
    }

    return null;
  }

  Stream<List<Post>> get getPosts => userDoc
      .collection(POSTS_COLLECTION_NAME)
      .snapshots()
      .map(_postFromSnapshot);

  List<Post> _postFromSnapshot(QuerySnapshot snap) =>
      // TODO: Posts with empty fields?
      snap.documents
          .map(
            (doc) => Post(
              doc.data['recipient'] ?? '',
              doc.data['message'] ?? '',
            ),
          )
          .toList();
}
