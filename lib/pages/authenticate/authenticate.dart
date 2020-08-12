import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email;
  String _password;

  void submitForm() async {
    if (_formKey.currentState.validate()) {
      AuthResult result;
      final auth = FirebaseAuth.instance;

      if (_isLogin) {
        result = await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        result = await auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
      }

      print(result.user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (val) => setState(() => _email = val),
                validator: _emailValidator,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (val) => setState(() => _password = val),
                validator: (val) =>
                    val.isEmpty ? 'A password is required' : null,
                obscureText: true,
              ),
              SizedBox(height: 48),
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: submitForm,
                child: Text(_isLogin ? 'Login' : 'Register'),
              ),
              SizedBox(height: 48),
              RaisedButton(
                elevation: 0.0,
                color: Colors.transparent,
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(
                  _isLogin ? 'Register here' : 'Login here',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String _emailValidator(String email) {
  final emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = new RegExp(emailPattern);

  if (!regex.hasMatch(email)) {
    return 'Invalid email';
  }

  return null;
}
