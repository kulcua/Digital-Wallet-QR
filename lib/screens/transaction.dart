import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymangement/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Giao dịch',
              style: TextStyle(color: Colors.brown[800], fontSize: 18)),
          backgroundColor: Color(0xfff1d1d1),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'NGUỒN TIỀN',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                  ),
                ),
                Card(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25,20,20,20),
                        child: Icon(Icons.account_balance_wallet, size: 45.0, color:Color(0xff7d5a5a)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ví điện tử',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                        color: Colors.brown[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                          ),
                          Text(
                            '1,000,000đ',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                        color: Colors.brown[300],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                          )
                        ],
                      ),
                      Spacer(),
                      FlatButton(
                        child: Text(
                          'Thay đổi',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.blue[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'THÔNG TIN NGƯỜI NHẬN',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                  ),
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
                              'Tên người nhận',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.brown[300],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            Text(
                              'Song Thị Méo',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.brown[800],
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
                              'Số điện thoại',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.brown[300],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            Text(
                              '1231231234',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.brown[800],
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
                              'Thời gian giao dịch',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.brown[300],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            Text(
                              '16:00 19/05/20',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.brown[800],
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
              ]),
        ));
  }
}
