import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;
  final String name;

  User(FirebaseUser fbUser, {this.name}) : uid = fbUser.uid;
}
