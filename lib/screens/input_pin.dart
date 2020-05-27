import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/wrapper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InputPin extends StatefulWidget {

  final User user;

  InputPin({this.user});

  @override
  _InputPinState createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {

  final _formKey = GlobalKey<FormState>();
  String _pin = '';
  bool _isLoading = false;

  _submit() async {
    if (_formKey.currentState.validate() && !_isLoading) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

       //Update user in database
      User user = User(
        id: widget.user.id,
        name: widget.user.name,
        money: widget.user.money,
        pin: _pin,
      );

      print('lai la pin $_pin');
      // Database update
      DatabaseService.updateUser(user);

      print('pin qua home');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Wrapper()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Nhập mã PIN',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                  color: Colors.brown[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: PinCodeTextField(
                onChanged: (input) {
                  _pin = input;
                  print(_pin);
                },
                textStyle: TextStyle(fontWeight: FontWeight.w100, fontSize: 10),
                textInputType: TextInputType.number,
                length: 6,
                obsecureText: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  selectedColor: Colors.brown,
                  inactiveColor: Colors.grey,
                  activeColor: Colors.pink[100],
                  fieldHeight: 50,
                  fieldWidth: 40,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: _submit,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Color(0xfff1d1d1),
              padding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
              child: Text(
                "Xác nhận",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
