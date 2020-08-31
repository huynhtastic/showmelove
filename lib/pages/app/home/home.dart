import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showsomelove/widgets/animated_fab.dart';

import '../../../models/user.dart';
import '../../../services/user_service.dart';
import 'widgets/new_post.dart';
import 'widgets/posts_list.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return FutureBuilder<FirebaseUser>(
      future: auth.currentUser(),
      builder: (context, snapshot) {
        Widget body = Text('NO DATA');

        if (snapshot.connectionState == ConnectionState.waiting) {
          body = CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final userService = UserService(User(snapshot.data));
          body = PostsList(userService);
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              MaterialButton(
                onPressed: () async => auth.signOut(),
                child: Text('Sign Out'),
              )
            ],
          ),
          body: Center(child: body),
          floatingActionButton: AnimatedFab(title: 'New Post', body: NewPost()),
        );
      },
    );
  }
}
