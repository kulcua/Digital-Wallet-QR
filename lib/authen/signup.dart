import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:moneymangement/services/auth.dart';
import 'package:moneymangement/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //bool isLoading = false;

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController phoneTextEditingController =
      new TextEditingController();

  String email = '';
  String password = '';
  String error = '';

  signMeUp() {
    if (_formKey.currentState.validate()) {

      Map<String, String> userInfoMap = {
        "email": emailTextEditingController.text,
        "name": nameTextEditingController.text,
        "phone": phoneTextEditingController.text,
        "money": '10000000'
      };
      _auth
          .registerWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
            //print("${val}");
        databaseMethods.uploadUserInfo(userInfoMap);
//      Navigator.pushReplacement(
//            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

//    setState(() {
//      isLoading = true;
//    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 40.0,
                color: Colors.blue,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                controller: emailTextEditingController,
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                controller: passwordTextEditingController,
                validator: (val) => val.length < 6
                    ? 'Password must be than 6 characters'
                    : null,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                controller: nameTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                ),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              color: Colors.blue,
              onPressed: () async {
                signMeUp();
                if (_formKey.currentState.validate()) {
                  dynamic result =
                      await _auth.registerWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      error = 'Please supply a valid email';
                    });
                  }
                }
              },
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white),
              ),
            ),
            FlatButton(
              child: Text('Sign in'),
              onPressed: () {
                widget.toggleView();
              },
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    ));
  }
}
