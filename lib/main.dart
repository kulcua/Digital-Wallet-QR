import 'package:flutter/material.dart';
import 'package:moneymangement/models/user.dart';
import 'package:moneymangement/services/auth.dart';
import 'package:moneymangement/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
