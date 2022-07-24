import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Future<String?> signUp(
      {required String email, required String password}) async {
    SharedPreferences prefs;

    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', value.user!.uid.toString());
        final data = <String, dynamic>{"email": email, "balance": 100000000};
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid.toString())
            .set(data);
      });
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for the email';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password).then((value) {
            prefs.setString('uid', value.user!.uid);
      });

      final db = await FirebaseFirestore.instance;
      db.collection("users").doc(prefs.getString('uid')).get().then((value){
        prefs.setString('email', value.data()!['email']);
        prefs.setInt('balance', value.data()!['balance']);
        print(value.data());
        print(prefs.getInt('balance'));
        print(prefs.getString('email'));
      });

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  // Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();
  //
  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     try {
  //       final UserCredential userCredential =
  //           await auth.signInWithCredential(credential);
  //
  //       user = userCredential.user;
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           AuthService.customSnackBar(
  //             content: 'The account already exists with a different credential',
  //           ),
  //         );
  //       } else if (e.code == 'invalid-credential') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           AuthService.customSnackBar(
  //             content: 'Error occurred while accessing credentials. Try again.',
  //           ),
  //         );
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         AuthService.customSnackBar(
  //           content: 'Error occurred using Google Sign In. Try again.',
  //         ),
  //       );
  //     }
  //   }
  //
  //   return user;
  // }

  static Future<void> signOut({required BuildContext context}) async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}
