import 'package:flutter/material.dart';

import 'auth.dart';
import 'pages/app/home/home.dart';
import 'pages/app/view_post/view_post.dart';
import 'pages/authenticate/authenticate.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  Auth.routeName: (_) => Auth(),
  Authenticate.routeName: (_) => Authenticate(),
  Home.routeName: (_) => Home(),
  ViewPost.routeName: (context) => ViewPost(
      post: (ModalRoute.of(context).settings.arguments as ViewPostArgs).post),
};
