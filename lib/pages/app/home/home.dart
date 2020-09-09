import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:showsomelove/widgets/animated_fab.dart';

import '../../../models/user.dart';
import '../../../services/user.dart';
import 'widgets/new_post.dart';
import 'widgets/posts_list.dart';

final getIt = GetIt.I;

class Home extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final auth = GetIt.I.get<FirebaseAuth>();

    return FutureBuilder<FirebaseUser>(
      future: auth.currentUser(),
      builder: (context, snapshot) {
        print(snapshot);
        Widget body = Text('NO DATA');

        if (snapshot.connectionState == ConnectionState.waiting) {
          body = CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final userService = UserService(User(snapshot.data));
          getIt.registerSingleton<UserService>(userService);
          // TODO: Switch to getIt
          body = PostsList(userService);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('My Posts'),
            actions: [
              MaterialButton(
                onPressed: () async => auth.signOut(),
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
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
