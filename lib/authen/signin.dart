import 'package:flutter/material.dart';
import 'package:moneymangement/push_notification.dart';
import 'package:moneymangement/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServices _auth = AuthServices();
  final PushNotificationsManager _noti = PushNotificationsManager();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello Bo!',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 40.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '0943523565',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.blue[700],
                fontSize: 20.0,
                letterSpacing: 2.5,
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
                _noti.init();
                print(email);
                print(password);
              },
              child: Text(
                "Sign in",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white),
              ),
            ),
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.fingerprint),
                label: Text('Fingerprint unlock')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "Forget password",
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Text(
                    "Sign up",
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
