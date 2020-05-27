import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultTransaction extends StatefulWidget {
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
            color: Color(0xfff1d1d1),
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
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.brown[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child:  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Bạn đã thanh toán thành công 1.000.000 cho tui',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                textAlign: TextAlign.center,
              ),
            )
          ),
          SizedBox(height: 30.0,),
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
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.brown[300],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Text(
                        '5,000,000',
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
                        'Mã giao dịch',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.brown[300],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Text(
                        '151521354546',
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
          SizedBox(height: 30),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Color(0xfff1d1d1),
              onPressed: () => {},
              padding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 80.0),
              child: Text(
                'Màn hình chính',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.brown[800],
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
