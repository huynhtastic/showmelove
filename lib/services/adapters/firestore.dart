import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/utils/contains_test_object.dart';

class FirestoreAdapter {
  final Firestore firestore;

  static const usersCollection = 'users';
  static const postsCollection = 'posts';

  FirestoreAdapter({Firestore firestore})
      : assert(
          containsTestObject(firestore),
          'Tests require a mock firestore instance',
        ),
        this.firestore = firestore ?? Firestore.instance {
    containsTestObject(firestore);
  }

  Future<Post> createPost(
    String senderUid,
    String recipientName,
    String message,
    String imageUrl,
  ) async {
    final newPost = await firestore.collection(postsCollection).add({
      'sender': senderUid,
      'recipient': recipientName,
      'message': message,
      'imageUrl': imageUrl,
      'claimed': false,
    });

    await firestore.collection(usersCollection).document(senderUid).updateData({
      'posts': FieldValue.arrayUnion([newPost.documentID]),
    });

    return _postFromDocument(await newPost.get());
  }

  Stream<List<Post>> getPosts(String uid) async* {
    final userSnaps =
        firestore.collection(usersCollection).document(uid).snapshots();
    await for (final snap in userSnaps) {
      yield await _getUserPosts(snap);
    }
  }

  Future<List<Post>> _getUserPosts(DocumentSnapshot snap) async {
    final List<dynamic> userPostIds = snap.data['posts'];
    return await Future.wait(userPostIds.map((postId) async {
      final postDoc =
          await firestore.collection(postsCollection).document(postId).get();
      return _postFromDocument(postDoc);
    }));
  }

  Post _postFromDocument(DocumentSnapshot doc) => Post(
        doc.data['sender'] ?? '',
        doc.data['recipient'] ?? '',
        doc.data['message'] ?? '',
        doc.data['imageUrl'] ?? '',
      );

  Future<void> updateUserData(String uid, String name) async => {
        await firestore.collection(usersCollection).document(uid).setData({
          'name': name,
        }, merge: true)
      };
}
