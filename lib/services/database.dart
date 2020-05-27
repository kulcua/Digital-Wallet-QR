import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/utilities/constants.dart';

class DatabaseService {

  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }

  static void updateUser(User user) {
    print('user idddd ${user.id}');
    usersRef.document(user.id).updateData({
      'name': user.name,
      'money': user.money,
      'pin': user.pin,
    });
  }

  static void createTransaction(TransactionModel trans) {
    // Add user to current user's following collection
    transactionsRef.document(trans.idSender).setData({
      'idSender': trans.idSender,
      'idReceiver': trans.idReceiver,
      'state': trans.state,
      'money': trans.money,
      'time': trans.time,
      'typeTransaction': trans.typeTransaction,
    });
  }
}
