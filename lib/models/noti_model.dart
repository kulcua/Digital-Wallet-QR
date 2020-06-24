import 'package:cloud_firestore/cloud_firestore.dart';

class Noti {
  final String id;
  final String authorId;
  final Timestamp timestamp;
  final int type;

  Noti({
    this.id,
    this.authorId,
    this.timestamp,
    this.type,
  });

  factory Noti.fromDoc(DocumentSnapshot doc) {
    return Noti(
      id: doc.documentID,
      authorId: doc['authorId'],
      timestamp: doc['timestamp'],
      type: doc['type'],
    );
  }
}