import 'package:flutter/material.dart';

import 'auth.dart';

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Auth(),
    );
  }
}

void main() {
  runApp(Main());
}
