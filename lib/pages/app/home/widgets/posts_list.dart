import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:showsomelove/pages/app/view_post/view_post.dart';
import 'package:showsomelove/utils/contains_test_object.dart';

import '../../../../models/post.dart';
import '../../../../services/user.dart';

class PostsList extends StatelessWidget {
  final UserService service;
  PostsList({UserService service})
      : assert(containsTestObject(service), 'Test requires mock UserService!'),
        this.service = service ?? GetIt.I.get<UserService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this.service.getPosts,
      builder: (context, AsyncSnapshot<List<Post>> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snap.hasData) {
          return Text('You have no memories to view!');
        }

        return ListView(
          children: snap.data
              .asMap()
              .entries
              .map((entry) => _toListTile(
                    entry.key,
                    entry.value,
                    context,
                  ))
              .toList(),
        );
      },
    );
  }
}

Widget _toListTile(int index, Post post, BuildContext context) => Card(
      child: ListTile(
        key: Key('post_tile$index'),
        onTap: () {
          Navigator.pushNamed(
            context,
            ViewPost.routeName,
            arguments: ViewPostArgs(post),
          );
        },
        leading: post.imageUrl.isNotEmpty
            ? CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: post.imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : null,
        title: Text(
          post.sender,
          key: Key('sender'),
        ),
        subtitle: Text(post.message),
      ),
    );
