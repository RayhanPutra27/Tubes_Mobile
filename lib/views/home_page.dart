import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_mobile/Services/auth_services.dart';
import 'package:tubes_mobile/Views/payment_page.dart';
import 'package:tubes_mobile/Views/sign_in_page.dart';
import 'package:tubes_mobile/views/activity_page.dart';
import 'package:tubes_mobile/views/transfer_page.dart';
import 'credits_page.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _menu = ['Credits', 'Transfer', 'Payment', 'Activity'];
  late SharedPreferences prefs;
  String email = '';
  int balance = 0;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email').toString();
    balance = prefs.getInt('balance')!;
    print("asd: $email $balance");
  }

  Widget _saldo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            "Balance: ",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
        Container(
          child: Text(
            balance.toString(),
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E5),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 8),
                          bottomRight: Radius.elliptical(30, 8),
                        ),
                        color: Colors.blueAccent,
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Container(
                        // decoration: const BoxDecoration(color: Color(0xFFd2d2d2)),
                        )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            setData();
                          },
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              email.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () async {
                              AuthService service =
                                  AuthService(FirebaseAuth.instance);
                              // addPage();
                              await prefs.clear();
                              service.logOut();
                              if (_firebaseAuth.currentUser == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SigninPage()),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 28,
                            ),
                          )),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 18),
                    child: _saldo(),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 18),
                        scrollDirection: Axis.vertical,
                        itemCount: _menu.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (_menu[index] == 'Credits') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreditsPage())).then((value) {
                                  email = prefs.getString('email')!;
                                  balance = prefs.getInt('balance')!;
                                });
                              } else if (_menu[index] == 'Transfer') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransferPage())).then((value) {
                                  email = prefs.getString('email')!;
                                  balance = prefs.getInt('balance')!;
                                });
                              } else if (_menu[index] == 'Payment') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentPage()));
                              } else if (_menu[index] == 'Activity') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActivityPage()));
                              }
                              print('item : ${_menu[index]} Pressed');
                            },
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _menu[index],
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF000000)),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
