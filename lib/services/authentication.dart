import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:showsomelove/models/user.dart';

import './user_service.dart';

class AuthenticationService {
  static const Map<String, String> errors = {
    'ERROR_USER_NOT_FOUND': 'Account not found',
    'ERROR_WRONG_PASSWORD': 'Incorrect password',
  };
  final fbAuth = FirebaseAuth.instance;

  Future<User> registerUser(String email, String password, String name) async {
    final result = await fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = User(result.user);
    await _initializeUserDocument(user, name);

    return user;
  }

  Future<String> signInUser(String email, String password) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on PlatformException catch (e) {
      return e.code;
    }
  }

  Future<void> _initializeUserDocument(User user, String name) async {
    final service = UserService(user);
    await service.updateUserData(name);
  }

  Future<void> signOutUser() async {
    await fbAuth.signOut();
  }
}
