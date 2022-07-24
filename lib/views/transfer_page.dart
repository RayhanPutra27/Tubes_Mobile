import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes_mobile/Services/firestore_services.dart';

class TransferPage extends StatefulWidget {
  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
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
      body: Container(
        margin: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 8,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Bank Destination :',
                      ),
                      controller: _bankController,
                    )),
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ListView.builder(
                                          itemCount: _bankList.length,
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return SingleChildScrollView(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _bankController.text =
                                                      _bankList[index];
                                                },
                                                child: ListTile(
                                                    title: Center(
                                                  child: Text(_bankList[index]),
                                                )),
                                              ),
                                            );
                                          }),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Close"))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text('Bank'),
                    ))
              ],
            )),
            Container(
                margin: EdgeInsets.only(top: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Destination account :',
                          ),
                          controller: _destController,
                        )),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter Nominal :'),
                        TextFormField(
                          decoration: InputDecoration(hintText: '00000000'),
                          controller: _nominalController,
                        ),
                      ],
                    )),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 18),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      var user = await FirebaseAuth.instance.currentUser!;
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
                        fs.addTransfer(
                            uid: uid,
                            destBank: _bankController.text,
                            destAcc: int.parse(_destController.text),
                            nominal: int.parse(_nominalController.text),
                            created: DateTime.now());

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Transfer'),
                  ),
                ))
          ],
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
