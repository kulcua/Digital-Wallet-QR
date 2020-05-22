import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymangement/module/user_model.dart';
import 'package:moneymangement/utilities/constants.dart';

class DatabaseService {
  //final String uid;

 // DatabaseService({this.uid});

//  final CollectionReference userCollection =
//      Firestore.instance.collection('users');

//  Future uploadUserInfo(
//      String name, String money, String email, String phone) async {
//    return await userCollection.document(uid).setData({
//      'name': name,
//      'money': money,
//      'email': email,
//      'phone': phone,
//    });
//  }

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

}
