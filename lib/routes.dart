import 'auth.dart';
import 'pages/app/home/home.dart';
import 'pages/authenticate/authenticate.dart';

final routes = {
  Auth.routeName: (_) => Auth(),
  Authenticate.routeName: (_) => Authenticate(),
  Home.routeName: (_) => Home(),
};
