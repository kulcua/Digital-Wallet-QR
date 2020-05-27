import 'package:flutter/material.dart';
import 'package:moneymangement/authen/authen.dart';
import 'package:moneymangement/module/user.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:moneymangement/screens/input_pin.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'module/user_model.dart';

class Wrapper extends StatelessWidget {
  String get userId => null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    print(user);
    // return Home or Authentication
    if (user == null)
      return Authentication();
    else
      return FutureBuilder(
          future: usersRef.document(user.currentUserId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            User user = User.fromDoc(snapshot.data);
            print('nameee ${user.pin}');
            print('nameee ${user.name}');
            if (user.pin == '0')
              return InputPin(user: user,);
            else
              return Home(user: user,);
          });
  }
}
