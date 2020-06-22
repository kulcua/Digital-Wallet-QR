import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/card_model.dart';
import 'package:moneymangement/services/database.dart';

class CardDetail extends StatefulWidget {
  final String uid;
  final CardModel cardModel;

  CardDetail({this.cardModel, this.uid});

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết',
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
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.redAccent[400],
              onPressed: () {
                DatabaseService.deleteCard(widget.cardModel, widget.uid);
                Navigator.pop(context);
              },
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
              child: Text(
                "Huỷ liên kết thẻ",
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
    );
  }
}
