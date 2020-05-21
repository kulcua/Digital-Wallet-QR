import 'package:flutter/material.dart';
import 'package:moneymangement/push_notification.dart';
import 'package:moneymangement/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final PushNotificationsManager noti = PushNotificationsManager();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Chào Bò tui!',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 40.0,
                  color: Color(0xff7d5a5a),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '0943523565',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Color(0xff7d5a5a),
                  fontSize: 20.0,
                  letterSpacing: 2.5,
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
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                color: Color(0xff7d5a5a),
                onPressed: () async {
                  noti.init();
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Vui lòng kiểm tra lại thông tin đăng nhập';
                      });
                    }
                  }
                },
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Source Sans Pro',
                      color: Colors.white),
                ),
              ),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.fingerprint),
                  label: Text('Mở khoá bằng vân tay')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      /*...*/
                    },
                    child: Text(
                      "Quên mật khẩu",
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text(
                      "Đăng kí",
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        )),
      ),
    );
  }
}
