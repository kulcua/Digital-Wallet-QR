import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/user.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/services/database.dart';
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
  User _profileUser;

  @override
  void initState()
  {
    super.initState();
    _setupProfileUser();
  }

  _setupProfileUser() async {
    User profileUser = await DatabaseService.getUserWithId(widget.user.id);
    setState(() {
      _profileUser = profileUser;
    });
  }

  buildProfileInfo(User user) {
    print('user info ${user.name}');
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Xin chào,',
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                  Text(
                    user.name,
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    NumberFormat("#,###","vi").format(user.money),
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  Text(
                    'VND',
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
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
