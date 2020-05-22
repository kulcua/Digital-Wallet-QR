import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:moneymangement/module/user_model.dart';
import 'package:moneymangement/screens/input_pin.dart';
import 'package:moneymangement/screens/user_page.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'history_page.dart';
import 'mainpage.dart';
import 'setting_page.dart';

class Home extends StatefulWidget {
//  final String userId;
//
//  Home({this.userId});

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MainPage(),
            History(),
            UserPage(),
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
        backgroundColor: Color(0xfffaf2f2),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home, color: Colors.brown[800]),
              title: Text('Trang chủ',
                  style: TextStyle(color: Colors.brown[800])),
              activeColor: Color(0xfff1d1d1)),
          BottomNavyBarItem(
              icon: Icon(Icons.access_time, color: Colors.brown[800]),
              title: Text('Giao dịch',
                  style: TextStyle(color: Colors.brown[800])),
              activeColor: Color(0xfff1d1d1)),
          BottomNavyBarItem(
              icon: Icon(Icons.account_circle, color: Colors.brown[800]),
              title: Text('Tài khoản',
                  style: TextStyle(color: Colors.brown[800])),
              activeColor: Color(0xfff1d1d1)),
          BottomNavyBarItem(
              icon: Icon(Icons.settings, color: Colors.brown[800]),
              title:
                  Text('Cài đặt', style: TextStyle(color: Colors.brown[800])),
              activeColor: Color(0xfff1d1d1)),
        ],
      ),
    );
  }
}
