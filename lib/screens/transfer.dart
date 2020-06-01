import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/result_transaction.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/currency.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Transfer extends StatefulWidget {
  final User user;

  Transfer({this.user});

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  String phone = '';
  String _pin = '';
  bool _isLoading = false;
  int money;
  final _formKey = GlobalKey<FormState>();
  User userReceiver;

  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _user;

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
                        builder: (context) =>
                            Transfer(
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
        print(widget.user.money);
        // print(userReceiver.name);
//        print(transId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ResultTransaction(
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
      typeTransaction: 'Chuyển tiền',
    );

    DatabaseService.createTransactionSender(trans);
    DatabaseService.createTransactionReceiver(trans);


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
                  onPressed: _verifyPin,
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
            );
          });
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chuyển tiền',
            style: GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
          ),
          backgroundColor: Color(0xff5e63b6),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'NHẬP SỐ ĐIỆN THOẠI',
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,10 ),
                      child: TextFormField(
                        controller: _searchController,
                        style: GoogleFonts.muli(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Số điện thoại',
                        ),
                        onFieldSubmitted: (input) {
                          print('vo $input');
                          if (input.isNotEmpty) {
                            setState(() {
                              _user = DatabaseService.searchUser(input);
                            });
                          }
                        },
                        onChanged: (val) {
                          setState(() => phone = val);
                          print('phone ne $phone');
                        },
                        validator: (val) {
                          if (val.isEmpty) return 'Hãy nhập số điện thoại';
                          if(val == widget.user.phone) return 'Số điện thoại không hợp lệ';
                          return null;
                        },
                      ),
                    ),
                    _user == null
                        ? Center(
                    )
                        : FutureBuilder(
                      future: _user,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data.documents.length == 0) {
                          return Text('Không tìm thấy người dùng',
                            style: GoogleFonts.muli(
                                textStyle: TextStyle(
                                  color:  Colors.redAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )),);
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            userReceiver = User.fromDoc(snapshot.data.documents[index]);
                            print(userReceiver.name);
                            return Text(
                              userReceiver.name,
                              style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                    color:  Color(0xff5e63b6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'NHẬP SỐ TIỀN',
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    TextFormField(
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Số tiền'),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CurrencyFormat()
                      ],
                      onChanged: (val) {
                        setState(
                                () =>
                            money = int.parse(val.replaceAll('.', '')));
                        print('money ne $money');
                      },
                      validator: (val) {
                        if (val.isEmpty) return 'Hãy nhập số tiền';
                        if (money < 1000) {
                          return 'Số tiền phải lớn hơn 1.000';
                        }
                        if (money > widget.user.money) {
                          return 'Số dư trong ví không đủ';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Color(0xff5e63b6),
                onPressed: () async {
                  if (_formKey.currentState.validate())
                    _showVerifyPasswordPanel();
                },
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
