import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/constants.dart';
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

  _submit() async {
    if (_pin.length == 6) {
      usersRef.document(widget.user.id).updateData({'id': widget.user.id});
      // Database update
      usersRef.document(widget.user.id).updateData({'pin': _pin});

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
                'Vui lòng thiết lập mã PIN',
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                  color: Colors.black,
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
                  selectedColor: Colors.black,
                  inactiveColor: Colors.grey,
                  activeColor: Color(0xff5e63b6),
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
              color: Color(0xff5e63b6),
              padding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
              child: Text(
                "Xác nhận",
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                      color: Colors.white,
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
