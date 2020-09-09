import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showsomelove/pages/app/view_post/view_post.dart';
import 'package:showsomelove/services/user.dart';
import 'package:showsomelove/utils/required_validator.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final formKey = new GlobalKey<FormState>();
  String recipient;
  String message;
  Uint8List uploadedImage;

  File image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile.path);
    });
  }

  Future<void> submitForm() async {
    if (formKey.currentState.validate()) {
      final service = GetIt.I.get<UserService>();
      final post = await service.createPost(recipient, message, image);

      Navigator.pushReplacementNamed(
        context,
        ViewPost.routeName,
        arguments: ViewPostArgs(post),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 600,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                key: Key('recipient'),
                decoration: InputDecoration(labelText: 'Recipient:'),
                validator: requiredValidator,
                onChanged: (val) => setState(() => recipient = val),
              ),
              SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.multiline,
                key: Key('message'),
                maxLines: null,
                decoration: InputDecoration(labelText: 'Your message:'),
                validator: requiredValidator,
                onChanged: (val) => setState(() => message = val),
              ),
              SizedBox(height: 24),
              RaisedButton(
                onPressed: getImage,
                child: Text('Add a picture'),
              ),
              SizedBox(height: 48),
              RaisedButton(
                key: Key('submitPost'),
                onPressed: submitForm,
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
