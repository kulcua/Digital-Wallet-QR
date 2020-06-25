import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;

  Option({this.icon, this.title});
}

final options = [
  Option(
    icon: Icon(
      Icons.language,
      size: 30,
      color: Color(0xff5e63b6),
    ),
    title: 'Ngôn ngữ',
  ),
  Option(
    icon: Icon(Icons.security, size: 30, color: Color(0xff5e63b6)),
    title: 'Bảo mật tài khoản',
  ),
  Option(
    icon:  Icon(Icons.live_help, size: 30, color: Color(0xff5e63b6)),
    title: 'Trung tâm trợ giúp',
  ),
  Option(
    icon:  Icon(Icons.star, size: 30, color: Color(0xff5e63b6)),
    title: 'Đánh giá ứng dụng',
  ),
  Option(
    icon: Icon(Icons.info_outline,
        size: 30, color: Color(0xff5e63b6)),
    title: 'Giới thiệu ứng dụng',
  ),
  Option(
    icon:  Icon(Icons.exit_to_app, size: 30, color: Color(0xff5e63b6)),
    title: 'Đăng xuất',
  ),

];