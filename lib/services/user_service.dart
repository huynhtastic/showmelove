import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/models/user.dart';

class UserService {
  static const COLLECTION_NAME = 'users';
  static const POSTS_COLLECTION_NAME = 'posts';

  final User user;
  final DocumentReference userDoc;

  UserService(this.user)
      : this.userDoc =
            Firestore.instance.collection(COLLECTION_NAME).document(user.uid);

  Future<void> updateUserData(String name) async {
    await userDoc.setData({
      'name': name,
    }, merge: true);
  }

  Future createPost(String recipient, String message) async {
    final newPost = await userDoc.collection(POSTS_COLLECTION_NAME).add({
      'recipient': recipient,
      'message': message,
    });

    print(newPost);
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
