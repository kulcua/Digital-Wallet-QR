import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/card_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/addcard.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/card_tile.dart';

class CardManagement extends StatefulWidget {
  final User user;

  CardManagement({this.user});

  @override
  _CardManagementState createState() => _CardManagementState();
}

class _CardManagementState extends State<CardManagement> {
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
          state: 'deleteCard',
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
          'Thêm thẻ/tài khoản',
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
              'TÀI KHOẢN',
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
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
            ),
            width: double.infinity,
            child: FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCard(
                                user: widget.user,
                              )));
                },
                icon: Icon(Icons.add, color: Colors.grey),
                label: Text(
                  'Thêm thẻ/tài khoản',
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hạn mức giao dịch',
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                  Text(
                    '20.000.000đ/ngày',
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
