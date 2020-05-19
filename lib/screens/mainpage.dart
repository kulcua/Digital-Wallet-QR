import 'package:flutter/material.dart';
import 'package:moneymangement/module/user.dart';
import 'package:moneymangement/services/database.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'package:moneymangement/module/user_model.dart';
import 'package:provider/provider.dart';
import 'griddashboad.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  buildProfileInfo(User user) {
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
                  user.money,
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
          FutureBuilder(
              future: usersRef.document(userId).get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                User user = User.fromDoc(snapshot.data);
                return Container(
                  child: buildProfileInfo(user),
                );
              }),
          SizedBox(
            height: 40,
          ),
          GridDashboard(),
          //test
        ],
      ),
    );
  }
}
