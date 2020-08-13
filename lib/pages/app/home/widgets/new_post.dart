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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
