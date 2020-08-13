import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../models/post.dart';
import '../../../../services/user_service.dart';

class PostsList extends StatelessWidget {
  final UserService service;
  PostsList(this.service);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this.service.getPosts,
      builder: (context, snap) {
        print(snap.hasData);
        if (snap.hasData) {
          print(snap.data);
        }
        return Text('hello');
      },
    );
  }
}
