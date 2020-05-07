import 'package:flutter/material.dart';
import 'package:moneymangement/authen/authen.dart';
import 'package:moneymangement/module/user.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return Home or Authentication
    if (user == null)
      return Authen();
    else
      return Home();
  }
}
