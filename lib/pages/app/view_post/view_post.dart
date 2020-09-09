import 'package:flutter/material.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/utils/contains_test_object.dart';

import 'widgets/bordered_image.dart';
import 'widgets/recipient_line.dart';

class ViewPostArgs {
  final Post post;

  ViewPostArgs(this.post);
}

class ViewPost extends StatefulWidget {
  static const routeName = 'view_post';
  final Post post;

  ViewPost({Key key, this.post}) : super(key: key) {
    if (!containsTestObject(this.post))
      print('Test did not pass a post object via constructor.');
  }

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipientLine(widget.post.recipient),
              SizedBox(height: 24.0),
              BorderedImage(widget.post.imageUrl),
              SizedBox(height: 24.0),
              Text(widget.post.message),
            ],
          ),
        ),
      ),
    );
  }
}
