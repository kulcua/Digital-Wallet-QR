import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:moneymangement/wrapper.dart';

class ResultTransaction extends StatefulWidget {
  final int moneyTrans;
  final int moneyUser;
  final String nameReceiver;
  final String idTrans;

  ResultTransaction(
      {this.moneyTrans, this.moneyUser, this.nameReceiver, this.idTrans});

  @override
  _ResultTransactionState createState() => _ResultTransactionState();
}


class _ResultTransactionState extends State<ResultTransaction> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 220.0,
            width: double.infinity,
            color: Color(0xff5e63b6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.check,
                    color: Colors.green[400],
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Giao dịch thành công',
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
                )
              ],
            ),
          ),
          Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Bạn đã thanh toán thành công ${ NumberFormat("#,###","vi").format(widget.moneyTrans)}đ cho ${widget.nameReceiver}',
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
                  textAlign: TextAlign.center,
                ),
              )),
          SizedBox(
            height: 30.0,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Số dư trong ví',
                        style: GoogleFonts.muli(
                            textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      Text(
                        NumberFormat("#,###","vi").format(widget.moneyUser-widget.moneyTrans),
                        style: GoogleFonts.muli(
                            textStyle: TextStyle(
                          color: Colors.black,
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
                        'Mã giao dịch',
                        style: GoogleFonts.muli(
                            textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      Text(
                        widget.idTrans,
                        style: GoogleFonts.muli(
                            textStyle: TextStyle(
                          color: Colors.black,
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
          SizedBox(height: 30),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Color(0xff5e63b6),
              onPressed: ()
              {
//                Navigator.popUntil(context, ModalRoute.withName('/wrapper'));
//                Navigator.pushReplacement(context,
//                    MaterialPageRoute(builder: (context) => Wrapper()));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Wrapper()),
                      (Route<dynamic> route) => false,
                );
              },
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
              child: Text(
                'Màn hình chính',
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
    );
  }
}
