import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/card_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/card_tile.dart';

class CashIn extends StatefulWidget {

  final User user;

  CashIn({this.user});

  @override
  _CashInState createState() => _CashInState();
}

class _CashInState extends State<CashIn> {

  List<CardModel> _cards = [];

  void initState() {
    _setupCards();
    super.initState();
  }

  _setupCards() async {
    print('do set up  ${widget.user.id}');

    List<CardModel> cards = await DatabaseService.getUserCards(widget.user.id);
    setState(() {
      _cards = cards;
      _cards.forEach((card) {
        print(card.id);
      });
    });
  }

  _buildUserCards() {
    List<CardTile> cardList = [];
    _cards.forEach((card) {
      print(card.id);
      cardList.add(
        CardTile(
          state: 'cashIn',
          user: widget.user,
          cardId: card.id,
        ),
      );
    });
    return Column(children: cardList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nạp tiền vào tài khoản',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20,20,0,10),
            child: Text(
              'CHỌN THẺ',
              style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              _buildUserCards(),
            ],
          ),
        ],
      ),
    );
  }
}
