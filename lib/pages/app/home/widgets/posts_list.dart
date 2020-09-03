import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/post.dart';
import '../../../../services/user.dart';

class PostsList extends StatelessWidget {
  final UserService service;
  PostsList(this.service);

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
          children: snap.data.map(_toListTile).toList(),
        );
      },
    );
  }
}

Widget _toListTile(Post post) => Card(
      child: ListTile(
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
          post.recipient,
        ),
        subtitle: Text(post.message),
      ),
    );
