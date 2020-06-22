import 'package:flutter/material.dart';
import 'package:moneymangement/models/user.dart';
import 'package:moneymangement/screens/cardmanagement.dart';
import 'package:moneymangement/screens/cash_in.dart';
import 'package:moneymangement/screens/createQR.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:moneymangement/screens/transaction.dart';
import 'package:moneymangement/screens/transfer.dart';
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
