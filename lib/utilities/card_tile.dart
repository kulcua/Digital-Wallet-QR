import 'package:flutter/material.dart';
import 'package:moneymangement/models/card_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/services/database.dart';

class CardTile extends StatefulWidget {
  final String cardId;
  final User user;

  CardTile({this.cardId, this.user});

  @override
  _CardTileState createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {

  Stream<CardModel> cardAsyncer;
  CardModel _card;

  void initState() {
    cardAsyncer = DatabaseService.getCardStream(widget.cardId, widget.user);
    print('card asynd $cardAsyncer');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CardModel>(
        stream: cardAsyncer,
        builder: (context, snapshot) {
          print('snapshot tile ${snapshot.hasData}');
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          } else {
            _card = snapshot.data;
            print('_card $_card');
            return Container(
                decoration: new BoxDecoration(
                    border: new Border(
                        bottom: new BorderSide(color: Colors.grey[300]))),
                child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ListTile(
                        leading: Icon(
                          Icons.credit_card,
                          color: Colors.grey,
                        ),
                        title: Text(_card.cardNumber)))
          );
        }
        });
  }
}
