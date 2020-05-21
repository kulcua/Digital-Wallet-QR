import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymangement/screens/setting_page.dart';

class User {
  //final String id;
  final String name;
  final String money;
  final String phone;
  final String email;

  User({this.email, this.name, this.money, this.phone});

  factory User.fromDoc(DocumentSnapshot document) {
    return User(
      //id: document.documentID,
      email: document['email'],
      name: document['name'],
      money: document['money'],
      phone: document['phone'],
    );
  }
}
