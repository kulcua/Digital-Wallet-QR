import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                  color: Color(0xff5e63b6),
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                )),
              ),
              Text(
                '0943523565',
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                  color: Color(0xff5e63b6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Color(0xff5e63b6),
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
                  validator: (val) =>
                      val.length < 6 ? 'Mật khẩu phải hơn 6 kí tự' : null,
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
                color: Color(0xff5e63b6),
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
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.fingerprint, color: Color(0xff142850),),
                  label: Text(
                    'Mở khoá bằng vân tay',
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Color(0xff142850),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      /*...*/
                    },
                    child: Text(
                      "Quên mật khẩu",
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Color(0xff142850),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text(
                      "Đăng kí",
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Color(0xff142850),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
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
