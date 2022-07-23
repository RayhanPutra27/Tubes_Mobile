import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tubes_mobile/Utils/auth_services.dart';
import 'package:tubes_mobile/sign_in_page.dart';
import 'package:tubes_mobile/transfer_page.dart';
import 'isi_pulsa_page.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _menu = ['Credits', 'Transfer', 'Payment', 'Activity'];

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
          child: const Text(
            "123456789",
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
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
                    flex: 7,
                    child: Container(
                        // decoration: const BoxDecoration(color: Color(0xFFd2d2d2)),
                        )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                      Expanded(
                          flex: 9,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              'Name/Email',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
                Center(
                  child: _saldo(),
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
                            onTap: () {
                              if (_menu[index] == 'Credits') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IsiPulsaPage()));
                              } else if (_menu[index] == 'Transfer') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TransferPage()));
                              } else if (_menu[index] == 'Activity') {
                                AuthService service =
                                    AuthService(FirebaseAuth.instance);
                                // addPage();
                                service.logOut();
                                if (_firebaseAuth.currentUser == null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninPage()),
                                  );
                                }
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
      ),
    );
  }
}
