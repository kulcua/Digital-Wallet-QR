import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneymangement/module/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/utilities/currency.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Transaction extends StatefulWidget {
  final String uid_receiver;

  Transaction({this.uid_receiver});

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool hasError = false;
  String currentText = "";

  infoReceiver(User user) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tên người nhận',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                  Text(
                    user.name,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Số điện thoại',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                  Text(
                    user.phone,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Thời gian giao dịch',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                  Text(
                    DateFormat('HH:mm dd-MM-yyyy')
                        .format(DateTime.now())
                        .toString(),
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    void _showVerifyPasswordPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Column(
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
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w100, fontSize: 10),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0,0),
                  child: FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.fingerprint),
                      label: Text(
                        'Xác thực bằng vân tay',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                      )),
                ),
              FlatButton(
                child: Text(
                  'Quên mật khẩu?',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              )
              ],
            );
          });
    }

    print('id receiver: ${widget.uid_receiver}');
    return Scaffold(
        appBar: AppBar(
          title: Text('Giao dịch',
              style: TextStyle(color: Colors.brown[800], fontSize: 18)),
          backgroundColor: Color(0xfff1d1d1),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'NHẬP SỐ TIỀN',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyFormat()
                    ],
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'THÔNG TIN NGƯỜI NHẬN',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                  ),
                ),
                FutureBuilder(
                    future: usersRef.document(widget.uid_receiver).get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      User user = User.fromDoc(snapshot.data);
                      return Container(
                        child: infoReceiver(user),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'NGUỒN TIỀN',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                  ),
                ),
                Card(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Icon(Icons.account_balance_wallet,
                            size: 45.0, color: Color(0xff7d5a5a)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ví điện tử',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              color: Colors.brown[800],
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            )),
                          ),
                          Text(
                            '1,000,000đ',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              color: Colors.brown[300],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                          )
                        ],
                      ),
                      Spacer(),
                      FlatButton(
                        child: Text(
                          'Thay đổi',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                            color: Colors.blue[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Color(0xfff1d1d1),
                    onPressed: () => _showVerifyPasswordPanel(),
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
                )
              ]),
        ));
  }
}
