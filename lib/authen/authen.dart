import 'package:flutter/material.dart';
import 'package:moneymangement/authen/signin.dart';
import 'package:moneymangement/authen/signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return SignIn(toggleView: toggleView);
    else
      return SignUp(toggleView: toggleView);
  }
}
