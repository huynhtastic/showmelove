import 'package:flutter/material.dart';
import 'package:showsomelove/services/authentication.dart';
import 'package:showsomelove/utils/required_validator.dart';

class Authenticate extends StatefulWidget {
  static const routeName = 'authenticate';

  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  final formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String email;
  String password;
  String name;

  void submitForm(BuildContext context) async {
    if (formKey.currentState.validate()) {
      final auth = AuthenticationService();
      String errorCode;
      if (isLogin) {
        errorCode = await auth.signInUser(email, password);
      } else {
        errorCode = await auth.registerUser(email, password, name);
      }
      if (errorCode != null) {
        print(errorCode);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              AuthenticationService.errors[errorCode],
            ),
          ),
        );
      }
    }
  }

  Widget nameField() => isLogin
      ? Container()
      : Column(
          children: [
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (val) => setState(() => name = val),
              validator: requiredValidator,
              key: Key('name'),
            ),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Container(
            width: 400,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    onChanged: (val) => setState(() => email = val),
                    validator: _emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    key: Key('email'),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    onChanged: (val) => setState(() => password = val),
                    validator: (val) =>
                        val.isEmpty ? 'A password is required' : null,
                    obscureText: true,
                    key: Key('password'),
                  ),
                  nameField(),
                  SizedBox(height: 48),
                  RaisedButton(
                    color: Colors.lightGreen,
                    onPressed: () => submitForm(context),
                    child: Text(isLogin ? 'Login' : 'Register'),
                    key: Key('authenticate'),
                  ),
                  SizedBox(height: 48),
                  RaisedButton(
                    elevation: 0.0,
                    color: Colors.transparent,
                    onPressed: () => setState(() => isLogin = !isLogin),
                    key: Key('toggleAuth'),
                    child: Text(
                      isLogin ? 'Register here' : 'Login here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
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
