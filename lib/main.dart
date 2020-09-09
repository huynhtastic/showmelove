import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'auth.dart';
import 'routes.dart';
import 'services/authentication.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    registerServices();
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      home: Auth(),
    );
  }
}

void registerServices() {
  final locator = GetIt.instance;

  if (!locator.isRegistered(instance: FirebaseAuth.instance)) {
    locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    locator.registerSingleton<AuthenticationService>(AuthenticationService());
  }
}

void main() {
  runApp(Main());
}
