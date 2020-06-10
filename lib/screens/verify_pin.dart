import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/transaction.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPin extends StatefulWidget {
  final User user;
  final String state;
  VerifyPin({this.user,this.state});

  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {

  String _pin = '';

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Giao dịch thất bại'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn nhập sai mã PIN'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Thử lại'),
              onPressed: () {
               // if (widget.state == 'transaction')
                  {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => Transaction(
//                              uidReceiver: widget.user.id,
//                              user: widget.user,
//                              checkPin: false,
//                            )));
                 Navigator.pop(context);
                  }
              },
            ),
          ],
        );
      },
    );
  }

  _verifyPin() {
    if (_pin == widget.user.pin) {
//      Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => Transaction(
//                uidReceiver: widget.user.id,
//                user: widget.user,
//                checkPin: true,
//              )));

    }
    else
      _showErrorDialog();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Nhập mã PIN',
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
                if (_pin.length == 6) _verifyPin();
              },
              textStyle:
              TextStyle(fontWeight: FontWeight.w100, fontSize: 10),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.fingerprint),
                label: Text(
                  'Xác thực bằng vân tay',
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                )),
          ),
          FlatButton(
            //onPressed: _verifyPin,
            child: Text(
              'Quên mật khẩu?',
              style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
