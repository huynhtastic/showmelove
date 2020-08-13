import 'package:firebase_auth/firebase_auth.dart';
import 'package:showsomelove/models/user.dart';

import './user_service.dart';

class AuthenticationService {
  final fbAuth = FirebaseAuth.instance;

  Future<User> registerUser(String email, String password, String name) async {
    // TODO: Handle errors in form
    final result = await fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = User(result.user);
    await _initializeUserDocument(user, name);

    return user;
  }

  Future<User> signInUser(String email, String password) async {
    final result = await fbAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = User(result.user);

    return user;
  }

  Future<void> _initializeUserDocument(User user, String name) async {
    final service = UserService(user);
    await service.updateUserData(name);
  }

  Future<void> signOutUser() async {
    await fbAuth.signOut();
  }
}
