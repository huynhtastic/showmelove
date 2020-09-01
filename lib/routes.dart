import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';
import 'pages/app/home/home.dart';
import 'pages/authenticate/authenticate.dart';

final routes = {
  Auth.routeName: (_) => Auth(auth: FirebaseAuth.instance),
  Authenticate.routeName: (_) => Authenticate(auth: FirebaseAuth.instance),
  Home.routeName: (_) => Home(),
};
