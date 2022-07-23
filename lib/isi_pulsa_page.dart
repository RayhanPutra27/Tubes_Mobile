import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes_mobile/Utils/firestore_services.dart';

class IsiPulsaPage extends StatefulWidget {
  @override
  State<IsiPulsaPage> createState() => _IsiPulsaPageState();
}

class _IsiPulsaPageState extends State<IsiPulsaPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  String nominalValue = '';
  String currentTime = DateFormat.Hm().format(DateTime.now());
  String currentDate = DateFormat.yMd().format(DateTime.now());
  final List _nominal = [
    10000,
    20000,
    25000,
    50000,
    75000,
    100000,
    200000,
    500000
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nominalController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter Destination Number :"),
                    TextField(
                      controller: numberController,
                    )
                  ],
                )),
            Expanded(
                flex: 7,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            childAspectRatio: 3),
                    itemCount: _nominal.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            nominalController.text = _nominal[index].toString();
                            print('item : ${_nominal[index]} Pressed');
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            _nominal[index].toString(),
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF9FCFF)),
                          ),
                          decoration: BoxDecoration(
                              color: const Color(0xFF1B82FF),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    })),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {},
                        controller: nominalController,
                        decoration: const InputDecoration(
                            labelText: "Enter Nominal (Min. 10.000)"),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var user = await FirebaseAuth.instance.currentUser!;
                          var uid = user.uid;
                          String currentTime =
                              DateFormat.Hm().format(DateTime.now());
                          String currentDate =
                              DateFormat.yMd().format(DateTime.now());
                          FirestoreServices fs = FirestoreServices();

                          print("UID      :::: $uid");
                          print("number   :::: ${numberController.text}");
                          print("Nominal  :::: ${nominalController.text}");
                          print("Time     :::: $currentTime");
                          print("Date     :::: $currentDate");
                          if (numberController.text == "" ||
                              nominalController.text == "") {
                            if (numberController.text == "") {
                              warnData("Number Still Empty");
                            } else {
                              warnData("Nominal Still Empty");
                            }
                          } else {
                            if (numberController.text.length < 10) {
                              warnData("Number must be more than 10");
                            } else if (int.parse(nominalController.text) <
                                10000) {
                              warnData("Nominal must be more than 10000");
                            } else {
                              final result = await fs.addCredits(
                                  uid: uid,
                                  destNum: numberController.text,
                                  nominal: int.parse(nominalController.text),
                                  date: currentDate,
                                  time: currentTime);
                              if(result!.contains("success")) {
                                warnData('Data Uploaded');
                              }
                            }
                          }
                        },
                        child: const Text("Send"))
                  ],
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
