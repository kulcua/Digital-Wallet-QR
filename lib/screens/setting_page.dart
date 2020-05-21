import 'package:flutter/material.dart';
import 'package:moneymangement/services/auth.dart';

class Setting extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text('Sign out'),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
    );
  }
}
