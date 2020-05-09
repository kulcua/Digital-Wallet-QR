import 'package:flutter/material.dart';
import 'package:moneymangement/module/user.dart';
import 'package:moneymangement/push_notification.dart';
import 'package:moneymangement/services/auth.dart';
import 'package:moneymangement/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
