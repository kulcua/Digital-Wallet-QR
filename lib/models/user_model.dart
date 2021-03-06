import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final int money;
  final String phone;
  final String email;
  final String pin;
  final String pushToken;

  User({this.id, this.email, this.name, this.money, this.phone, this.pin, this.pushToken});

  factory User.fromDoc(DocumentSnapshot document) {
    return User(
      id: document.documentID,
      email: document['email'],
      name: document['name'],
      money: document['money'],
      phone: document['phone'],
      pin: document['pin'],
      pushToken: document['pushToken']
    );
  }
}
