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

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
          Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextField(
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              )),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: TextField(
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
              print(email);
              print(password);
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
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
    ));
  }
}
