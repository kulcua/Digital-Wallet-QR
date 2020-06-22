import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/user_model.dart';

class UserPage extends StatefulWidget {
  User user;
  UserPage({this.user});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân',
          style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),),
        backgroundColor:Color(0xff5e63b6),
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/user.png'),
              ),
              SizedBox(height: 20,),
              Text(
                widget.user.name,
                style: GoogleFonts.lobster(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Color(0xff5e63b6),
                ),
              ),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Color(0xff5e63b6),
                    ),
                    title: Text(
                      widget.user.phone,
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ),
                  )),
              Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Color(0xff5e63b6),
                    ),
                    title: Text(
                      widget.user.email,
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ),
                  ))
            ],
          )),
    );
  }
}
