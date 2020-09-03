import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:showsomelove/models/user.dart';

import 'user.dart';

class AuthenticationService {
  final FirebaseAuth fbAuth = GetIt.I.get<FirebaseAuth>();
  static const Map<String, String> errors = {
    'ERROR_USER_NOT_FOUND': 'Account not found',
    'ERROR_WRONG_PASSWORD': 'Incorrect password',
    'ERROR_EMAIL_ALREADY_IN_USE': 'Email in use',
    'ERROR_WEAK_PASSWORD': 'Password must be at least 6 characters',
  };

  Future<String> registerUser(
    String email,
    String password,
    String name,
  ) async {
    try {
      final result = await fbAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _initializeUserDocument(result, name);
      return null;
    } on PlatformException catch (e) {
      return e.code;
    }
  }

  Future<String> signInUser(String email, String password) async {
    try {
      final result = await fbAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user != null ? null : 'ERROR_USER_NULL';
    } on PlatformException catch (e) {
      return e.code;
    }
  }

  Future<void> _initializeUserDocument(AuthResult result, String name) async {
    final user = User(result.user);
    final service = UserService(user);
    await service.updateUserData(name);
  }

  Future<void> signOutUser() async {
    await fbAuth.signOut();
  }
}
