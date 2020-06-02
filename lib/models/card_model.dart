import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String id;
  final String cardNumber;
  final String expiredDate;
  final String cvvCode;
  final String cardHolder;

  CardModel(
      {this.id,
      this.cardNumber,
      this.expiredDate,
      this.cvvCode,
      this.cardHolder});

  factory CardModel.fromDoc(DocumentSnapshot doc) {
    return CardModel(
      id: doc.documentID,
      cardNumber: doc['cardNumber'],
      expiredDate: doc['expiredDate'],
      cvvCode: doc['cvvCode'],
      cardHolder: doc['cardHolder'],
    );
  }
}