import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes_mobile/Services/firestore_services.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List _bankList = ['BRI', 'BNI', 'BCA', 'Bank Jatim'];
  TextEditingController _bankController = TextEditingController();
  TextEditingController _destController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Virtual Account :
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextFormField(
                    enabled: true,
                    decoration: InputDecoration(
                      labelText: 'Virtual Account :',
                    ),
                    controller: _bankController,
                  )),
                ],
              )),
              //Data Found!
              Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: Text('Data Found!')),
                      Flexible(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Check'),
                              )
                            ],
                          ))
                    ],
                  )),
              //Detail + Button
              Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Enter Nominal : '),
                                Text('Dani Setya'),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Payment Type : '),
                                Text('Token PLN'),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Nominal : '),
                                Text('150000'),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 18),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var user = await FirebaseAuth
                                        .instance.currentUser!;
                                    var uid = user.uid;
                                    String currentTime =
                                        DateFormat.Hm().format(DateTime.now());
                                    String currentDate =
                                        DateFormat.yMd().format(DateTime.now());
                                    FirestoreServices fs = FirestoreServices();

                                    if (_bankController.text == "" ||
                                        _destController.text == "" ||
                                        _nominalController.text == "") {
                                      warnData("Fill the empty data!");
                                    } else {
                                      // final result = await addTransfer(
                                      //     uid: uid,
                                      //     destBank: _bankController.text,
                                      //     destAcc:
                                      //         int.parse(_destController.text),
                                      //     nominal: int.parse(
                                      //         _nominalController.text),
                                      //     created: DateTime.now());
                                      //
                                      // if (result!.contains("success")) {
                                      //   warnData('Data Uploaded');
                                      // }
                                    }
                                  },
                                  child: Text('Transfer'),
                                ),
                              ))
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void warnData(String warn) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(warn),
      ),
    );
  }
}
