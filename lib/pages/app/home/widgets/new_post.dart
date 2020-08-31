import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showsomelove/models/user.dart';
import 'package:showsomelove/services/user_service.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final formKey = new GlobalKey<FormState>();
  String recipient;
  String message;
  Uint8List uploadedImage;

  Future<void> submitForm() async {
    if (formKey.currentState.validate()) {
      print('validated');
      // TODO: Move user to a provided value
      final auth = FirebaseAuth.instance;
      final user = User(await auth.currentUser());
      final service = new UserService(user);

      await service.createPost(recipient, message);
    }
  }

  // _startFilePicker() async {
  //   final uploadInput = FileUploadInputElement();
  //   uploadInput.accept = 'image/*';
  //   uploadInput.click();

  //   uploadInput.onChange.listen((e) {
  //     // read file content as dataURL
  //     final files = uploadInput.files;
  //     if (files.length == 1) {
  //       final file = files[0];
  //       final reader = FileReader();

  //       reader.onLoadEnd.listen((e) {
  //         print(reader.result);
  //         setState(() {
  //           uploadedImage = reader.result;
  //         });
  //       });

  //       reader.onError.listen((fileEvent) {
  //         print('ERROR');
  //       });

  //       reader.readAsArrayBuffer(file);
  //     }
  //   });
  // }

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
                validator: _requiredValidator,
                onChanged: (val) => setState(() => recipient = val),
              ),
              SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Your message:'),
                validator: _requiredValidator,
                onChanged: (val) => setState(() => message = val),
              ),
              SizedBox(height: 24),
              RaisedButton(
                // onPressed: _startFilePicker,
                onPressed: () {},
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

// TODO: Move to util
String _requiredValidator(String val) {
  if (val.isEmpty) {
    return 'A name is required';
  }

  return null;
}
