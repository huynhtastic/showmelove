import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/app/home/home.dart';
import 'pages/authenticate/authenticate.dart';

class Auth extends StatefulWidget {
  static const routeName = 'auth';

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final auth = FirebaseAuth.instance;
  bool isLoggedIn;

  @override
  void initState() {
    super.initState();

    auth.onAuthStateChanged
        .listen((user) => setState(() => isLoggedIn = user != null));

    Future.delayed(
      Duration(seconds: 1),
      () async {
        if (isLoggedIn == null) {
          final user = await auth.currentUser();
          setState(() => isLoggedIn = user != null);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (isLoggedIn) {
      case true:
        return Home();
      case false:
        return Authenticate();
      default:
        return _loadingWidget();
    }
  }
}

Widget _loadingWidget() => Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
