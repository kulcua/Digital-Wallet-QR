import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/user_page.dart';
import 'history_page.dart';
import 'mainpage.dart';
import 'setting_page.dart';

class Home extends StatefulWidget {
  final User user;

  Home({this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('home ${widget.user.name}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MainPage(
              user: widget.user,
            ),
            History(
              user: widget.user,
            ),
            UserPage(user: widget.user,),
            Setting(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        itemCornerRadius: 45,
        backgroundColor: Colors.white,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              title: Text(
                'Trang chủ',
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
              ),
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.access_time, color: Colors.black),
              title: Text(
                'Giao dịch',
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
              ),
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.account_circle, color: Colors.black),
              title: Text(
                'Tài khoản',
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
              ),
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.settings, color: Colors.black),
              title: Text(
                'Cài đặt',
                style: GoogleFonts.muli(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
              ),
              activeColor: Colors.white),
        ],
      ),
    );
  }
}
