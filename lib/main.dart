import 'package:flutter/material.dart';

import 'auth.dart';
import 'routes.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      home: Auth(),
    );
  }
}

void main() {
  runApp(Main());
}
