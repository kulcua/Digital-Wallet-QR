import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/screens/result_transaction.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/currency.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Transaction extends StatefulWidget {
  final String uidReceiver;
  final User user;

  Transaction({this.uidReceiver, this.user});

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final _formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = '';
  String _pin = '';
  bool _isLoading = false;
  int money = 0;
  User userReceiver;
//  String transId;

  _infoReceiver() {
    print('info ${userReceiver.name}');
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
                    userReceiver.name,
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
                    userReceiver.phone,
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
                    DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Transaction(
                              uidReceiver: widget.uidReceiver,
                              user: widget.user,
                            )));
              },
            ),
          ],
        );
      },
    );
  }

  _verifyPin() {
    print('verify pin');
    if (_formKey.currentState.validate() && !_isLoading) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      if (_pin == widget.user.pin) {
        print('vo submit');
        _submit();
        print(money);
        print( widget.user.money);
        print(userReceiver.name);
//        print(transId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultTransaction(
                      moneyTrans: money,
                      moneyUser: widget.user.money,
                      nameReceiver: userReceiver.name,
                      idTrans: '3458364913854',
                    )));
        print('da qua result');
      } else
        _showErrorDialog();
    }
  }

  _submit() async {
    print('vo submit');
    // Create transaction
    TransactionModel trans = TransactionModel(
      idSender: widget.user.id,
      idReceiver: userReceiver.id,
      state: 'success',
      money: money,
      time: Timestamp.fromDate(DateTime.now()),
      typeTransaction: 'Scan QR',
    );
    DatabaseService.createTransaction(trans);

//    transId = trans.id;
//    print('tran ne ${transId}');

    //update money for 2 users

    //sender
    print('sender money ${widget.user.name}');
    print('sender money ${widget.user.money}');
    User userSender = User(
      id: widget.user.id,
      name: widget.user.name,
      money: widget.user.money - money,
      pin: widget.user.pin,
    );

    //receiver
    print('receiver money ${userReceiver.name}');
    print('receiver money ${userReceiver.money}');
    userReceiver = User(
      id: userReceiver.id,
      name: userReceiver.name,
      money: userReceiver.money + money,
      pin: userReceiver.pin,
    );

    // Database update
    DatabaseService.updateUser(userSender);
    DatabaseService.updateUser(userReceiver);
  }

  @override
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
                      selectedColor: Colors.brown,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.pink[100],
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
                        style: GoogleFonts.openSans(
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

    //print('id receiver: ${widget.uid_receiver}');
    return Form(
      key: _formKey,
      child: Scaffold(
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
                      onChanged: (val) {
                        setState(
                            () => money = int.parse(val.replaceAll('.', '')));
                        print('money ne $money');
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CurrencyFormat()
                      ],
                      validator: (val) {
                        if (val.isEmpty) return 'Hãy nhập số tiền';
                        if (money < 1000) {
                          return 'Số tiền phải lớn hơn 1,000';
                        }
                        if (money > widget.user.money) {
                          return 'Số dư trong ví không đủ';
                        }
                        return null;
                      },
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
                      future: usersRef.document(widget.uidReceiver).get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        userReceiver = User.fromDoc(snapshot.data);
                        return Container(
                          child: _infoReceiver(),
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
                      onPressed: () async {
                        if (_formKey.currentState.validate())
                          _showVerifyPasswordPanel();
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 80.0),
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
                  ),
                ]),
          )),
    );
  }
}
