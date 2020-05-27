import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/user.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:provider/provider.dart';
import 'griddashboad.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  final User user;

  MainPage({this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  buildProfileInfo(User user) {
    print('user info ${user.name}');
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Xin chào,',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    color: Color(0xff7d5a5a),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  )),
                ),
                Text(
                  user.name,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.brown[700],
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
                  NumberFormat("#,###","vi").format(user.money),
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  )),
                ),
                Text(
                  'VND',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserData>(context).currentUserId;
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            child: buildProfileInfo(widget.user),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard(
            user: widget.user,
          ),
        ],
      ),
    );
  }
}
