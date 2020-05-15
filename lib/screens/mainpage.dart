import 'package:flutter/material.dart';
import 'griddashboad.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello again,',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Color(0xff7d5a5a),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          )),
                    ),
                    Text(
                      'My boooo',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Color(0xff7d5a5a),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '3,000,000 vnd',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Color(0xff7d5a5a),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Text(
                      'in your account',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Color(0xff7d5a5a),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        SizedBox(
          height: 40,
        ),
        GridDashboard(),
      ],
    );
  }
}