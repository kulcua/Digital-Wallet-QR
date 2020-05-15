import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'history_page.dart';
import 'mainpage.dart';
import 'setting_page.dart';
import 'user_page.dart';

class Home extends StatefulWidget {
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
      backgroundColor: Color(0xfffaf2f2),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MainPage(),
            History(),
            User(),
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
              icon: Icon(Icons.home, color: Color(0xff7d5a5a)),
              title: Text('Home', style: TextStyle(color: Color(0xff7d5a5a))),
              activeColor: Color(0xfff1d1d1)
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.access_time, color: Color(0xff7d5a5a)),
              title:
              Text('History', style: TextStyle(color: Color(0xff7d5a5a))),
              activeColor: Color(0xfff1d1d1)
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.account_circle, color: Color(0xff7d5a5a)),
              title:
              Text('Account', style: TextStyle(color: Color(0xff7d5a5a))),
              activeColor: Color(0xfff1d1d1)
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings, color: Color(0xff7d5a5a)),
              title:
              Text('Setting', style: TextStyle(color: Color(0xff7d5a5a))),
              activeColor: Color(0xfff1d1d1)
          ),
        ],
      ),
    );
  }
}

