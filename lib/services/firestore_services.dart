import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreServices {
  Future<String?> addCredits({
    required String uid,
    required String destNum,
    required int nominal,
    required DateTime created,
  }) async {
    SharedPreferences pref;
    try {
      pref = await SharedPreferences.getInstance();
      int total, current_balance;
      current_balance = pref.getInt('balance')!;
      total = current_balance - nominal;

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Credits')
          .add({
        'dest number': destNum,
        'nominal': nominal,
        'created': created
      }).then((documentSnapshot) {
        print("document ID : ${documentSnapshot.id}");
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'email': pref.getString('email'), 'balance': total});
      pref.setInt('balance', total);
      return 'Success';
    } catch (e) {
      print("Error : $e");
      return 'Failed';
    }
  }

  Future<String?> addTransfer(
      {required String uid,
      required String destBank,
      required int destAcc,
      required int nominal,
      required DateTime created}) async {
    SharedPreferences pref;
    try {
      pref = await SharedPreferences.getInstance();
      int total, current_balance;
      current_balance = pref.getInt('balance')!;
      total = current_balance - nominal;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Transfer')
          .add({
        'dest bank': destBank,
        'dest acc': destAcc,
        'nominal': nominal,
        'created': created
      }).then((documentSnapshot) {
        print("document ID : ${documentSnapshot.id}");
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'email': pref.getString('email'), 'balance': total});
      pref.setInt('balance', total);
      return 'Success';
    } catch (e) {
      print("Error : $e");
      return 'Failed';
    }
  }
}
