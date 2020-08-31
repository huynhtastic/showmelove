import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showsomelove/models/user.dart';
import 'package:showsomelove/services/user_service.dart';
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
      final auth = FirebaseAuth.instance;
      final user = User(await auth.currentUser());
      final service = new UserService(user);

      await service.createPost(recipient, message, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(uploadedImage);
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 600,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipient:'),
                validator: requiredValidator,
                onChanged: (val) => setState(() => recipient = val),
              ),
              SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.multiline,
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
