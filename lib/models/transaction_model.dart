import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String idSender;
  final String idReceiver;
  final String state;
  final int money;
  final Timestamp time;
  final String typeTransaction;

  TransactionModel(
      {this.id,
      this.idSender,
      this.idReceiver,
      this.state,
      this.money,
      this.time,
      this.typeTransaction});

  factory TransactionModel.fromDoc(DocumentSnapshot doc) {
    return TransactionModel(
      id: doc.documentID,
      idSender: doc['idSender'],
      idReceiver: doc['idReceiver'],
      state: doc['state'],
      money: doc['money'],
      time: doc['time'],
      typeTransaction: doc['typeTransaction'],
    );
  }
}