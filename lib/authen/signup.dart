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


  String email = '';
  String password = '';
  String name = '';
  String money = '1,000,000';
  String phone = '';
  String error = '';

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
              'Đăng kí',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 40.0,
                color: Color(0xff7d5a5a),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Color(0xff7d5a5a),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Nhập email' : null,
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
                validator: (val) => val.length < 6
                    ? 'Mật khẩu phải hơn 6 kí tự'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mật khẩu',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tên của bạn',
                ),
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Số điện thoại',
                ),
                onChanged: (val) {
                  setState(() => phone = val);
                },
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              color: Color(0xff7d5a5a),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result =
                      await _auth.registerWithEmailAndPassword(context, email, password, name, money, phone);
                  if (result == null) {
                    setState(() {
                      error = 'Email không tồn tại';
                    });
                  }
                }
              },
              child: Text(
                "Đăng kí",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Source Sans Pro',
                    color: Colors.white),
              ),
            ),
            FlatButton(
              child: Text('Đăng nhập'),
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
