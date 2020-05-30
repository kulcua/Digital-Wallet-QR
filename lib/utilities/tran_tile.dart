import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/result_transaction.dart';
import 'package:moneymangement/services/database.dart';

class TranTile extends StatefulWidget {
  final String tranid;
  final User user;

  TranTile({this.tranid, this.user});

  @override
  _TranTileState createState() => _TranTileState();
}

class _TranTileState extends State<TranTile> {
  Stream<TransactionModel> tranAsyncer;
  TransactionModel _tran;
  User userReceiver;

  void initState() {
    tranAsyncer = DatabaseService.getTranStream(widget.tranid, widget.user);
    super.initState();
  }

  String checkState(String state)
  {
    if(state == 'success')
      return 'Chuyển tiền thành công';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TransactionModel>(
        stream: tranAsyncer,
        builder: (context, snapshot) {
          print('snapshot tile ${snapshot.hasData}');
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          } else {
            _tran = snapshot.data;
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ResultTransaction(
                          moneyTrans: _tran.money,
                          moneyUser: widget.user.money,
                          nameReceiver: userReceiver.name,
                          idTrans: '3458364913854',
                        )),
              ),
              child:Container(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/check.png'),
                    ),
                    title: Text(
                      checkState(_tran.state),
                      style: GoogleFonts.muli(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FutureBuilder(
                            future: DatabaseService.getUserWithId(_tran.idReceiver),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox.shrink();
                              }
                              userReceiver = snapshot.data;
                              return Text(
                                'Bạn đã chuyển ${NumberFormat("#,###","vi").format(_tran.money)}đ cho ${userReceiver.name}',
                                style: GoogleFonts.muli(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              );
                            }),
                        SizedBox(height: 5.0),
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .add_jm()
                              .format(_tran.time.toDate(),
                          ),
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                    border: new Border(
                        bottom: new BorderSide(color: Colors.grey[300])
                    )
                ),
              ),
            );
          }
        });
  }
}
