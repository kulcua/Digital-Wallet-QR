import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymangement/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 40.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.blue,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextFormField(
                validator: (val) => val.length < 6
                    ? 'Password must be than 6 characters'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              color: Colors.blue,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result =
                      await _auth.registerWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      error = 'Please supply a valid email';
                    });
                  }
                }
              },
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white),
              ),
            ),
            FlatButton(
              child: Text('Sign in'),
              onPressed: () {
                widget.toggleView();
              },
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    ));
  }
}
