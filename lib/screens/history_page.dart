import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/tran_tile.dart';

class History extends StatefulWidget {
  final User user;

  History({this.user});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<TransactionModel> _trans = [];

  void initState() {
    _setupTrans();
    super.initState();
  }

  _setupTrans() async {
    print('do set up  ${widget.user.id}');

    List<TransactionModel> trans =
        await DatabaseService.getUserTrans(widget.user.id);
    setState(() {
      _trans = trans;
      _trans.forEach((tran) {
        print(tran.id);
      });
    });
  }

  _buildUserTrans() {
    List<TranTile> tranList = [];
    _trans.forEach((tran) {
      print(tran.id);
      tranList.add(
        TranTile(
          user: widget.user,
          tranid: tran.id,
        ),
      );
    });
    return Column( children: tranList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử giao dịch',
              style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),),
          backgroundColor:Color(0xff5e63b6),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _setupTrans();
          },
          child: ListView(
            children: <Widget>[
              _buildUserTrans(),
            ],
          ),
        ));
  }
}
