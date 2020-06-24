import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/card_model.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'package:moneymangement/utilities/currency.dart';
import 'package:moneymangement/wrapper.dart';

class CashOutDetail extends StatefulWidget {

  final CardModel cardModel;
  final User user;
  CashOutDetail({this.cardModel, this.user});

  @override
  _CashOutDetailState createState() => _CashOutDetailState();
}

class _CashOutDetailState extends State<CashOutDetail> {

  int money;

  final _formKey = GlobalKey<FormState>();

  _submit() async {
    print('vo submit');
    // Create transaction
    TransactionModel trans = TransactionModel(
      idSender: widget.user.id,
      idReceiver: null,
      state: 'success',
      money: money,
      time: Timestamp.fromDate(DateTime.now()),
      typeTransaction: 'Nap tien',
    );

    DatabaseService.createTransactionSender(trans);

    // Database update
    usersRef.document(widget.user.id).updateData({'money':  widget.user.money - money});

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Wrapper()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Rút tiền từ tài khoản',
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
            CreditCardWidget(
              cardBgColor: Colors.amber,
              cardNumber: widget.cardModel.cardNumber,
              expiryDate: widget.cardModel.expiredDate,
              cardHolderName: widget.cardModel.cardHolder,
              cvvCode: widget.cardModel.cvvCode,
              showBackView: false,
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
                  if( _formKey.currentState.validate())
                    _submit();
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

