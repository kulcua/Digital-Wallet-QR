import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:moneymangement/models/card_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/cardmanagement.dart';
import 'package:moneymangement/services/database.dart';

class AddCard extends StatefulWidget {
  final User user;
  AddCard({this.user});

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  _submit() async {
    print('vo submit');
    // Create transaction
    CardModel card = CardModel(
      cardNumber: cardNumber,
      expiredDate: expiryDate,
      cvvCode: cvvCode,
      cardHolder: cardHolderName,
    );

    DatabaseService.createCard(card, widget.user.id);

    Navigator.push(context,MaterialPageRoute(builder: (context)=> CardManagement(user: widget.user,)));
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thêm thẻ mới',
          style: GoogleFonts.muli(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )),
        ),
        backgroundColor: Color(0xff5e63b6),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardBgColor: Colors.amber,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Color(0xff5e63b6),
                onPressed: _submit,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
                child: Text(
                  "Xác nhận",
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
