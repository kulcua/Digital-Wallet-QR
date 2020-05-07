import 'package:flutter/material.dart';
import 'package:moneymangement/authen/signin.dart';
import 'package:moneymangement/authen/signup.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
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
