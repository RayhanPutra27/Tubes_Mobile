import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  Future<String?> addCredits({
    required String uid, required String destNum,
    required int nominal, required String date, required String time, }) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Credits')
          .add({
        'dest number': destNum,
        'nominal': nominal,
        'date': date,
        'hour': time
      }).then((documentSnapshot) {
        print("document ID : ${documentSnapshot.id}");
      });
      return 'Success';
    } catch (e) {
      print("Error : $e");
      return 'Failed';
    }
  }

  Future<String?> addTransfer({
    required String uid, required String destBank, required int destAcc,
    required int nominal, required String date, required String time, }) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Transfer')
          .add({
        'dest bank': destBank,
        'dest acc': destAcc,
        'nominal': nominal,
        'date': date,
        'hour': time
      }).then((documentSnapshot) {
        print("document ID : ${documentSnapshot.id}");
      });
      return 'Success';
    } catch (e) {
      print("Error : $e");
      return 'Failed';
    }
  }
}