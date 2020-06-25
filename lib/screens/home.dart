import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/transfer.dart';
import 'package:moneymangement/screens/user_page.dart';
import 'package:moneymangement/utilities/constants.dart';
import '../wrapper.dart';
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
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //configureRealtimePushNoti();
    _pageController = PageController();
    //showNotification(message);
    registerNotification();
    configLocalNotification();
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thông báo',
              style: GoogleFonts.muli(
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message['notification']['title'],
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ))),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Đóng',
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                    color: Color(0xff5e63b6),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ))),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Wrapper()),
                  (Route<dynamic> route) => false,
                );
              }, //=> Navigator.of(context).pop(),
            )
          ],
        ),
      );
      //Platform.isAndroid ? showNotification(message['notification']) : showNotification(message['aps']['alert']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      usersRef.document(widget.user.id).updateData({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

//  configureRealtimePushNoti() {
//    if(Platform.isIOS) {
//      getIOSPermissions();
//    }
//    _firebaseMessaging.getToken().then((token) {
//      usersRef.document(widget.user.id).updateData({"pushToken": token});
//    });
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> msg) async {
//        final String recipientId = msg ["data"]["recipient"];
//        final String body = msg["notification"]["body"];
//
//        if(recipientId == widget.user.id)
//          {
//            SnackBar snackBar = SnackBar(
//              backgroundColor: Colors.grey,
//              content: Text(body, style: TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,),
//            );
//            _scaffoldKey.currentState.showSnackBar(snackBar);
//          }
//      },
//    );
//  }
//
//  getIOSPermissions(){
//    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(alert: true, badge: true, sound: true));
//    _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
//      print("setting register : $settings");
//    });
//  }

//  @override
//  void dispose() {
//    _pageController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    print('home ${widget.user.name}');
    return Scaffold(
      key: _scaffoldKey,
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
            UserPage(
              user: widget.user,
            ),
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
