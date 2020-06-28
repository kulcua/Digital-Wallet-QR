import 'package:flutter/material.dart';
import 'package:moneymangement/models/user.dart';
import 'package:moneymangement/push_notification.dart';
import 'package:moneymangement/screens/splash_screen.dart';
import 'package:moneymangement/services/auth.dart';
import 'package:moneymangement/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  PushNotificationsManager _noti = new PushNotificationsManager();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _noti.init();
    return StreamProvider<UserData>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
