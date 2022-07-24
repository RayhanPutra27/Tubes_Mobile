import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tubes_mobile/models/credits.dart';
import 'package:tubes_mobile/models/payment.dart';
import 'package:tubes_mobile/models/transfers.dart';
import 'package:tubes_mobile/views/helper/credits_card.dart';
import 'package:tubes_mobile/views/helper/transfer_card.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Object> _creditsList = [];
  List<Object> _transferList = [];
  List<Object> _paymentList = [];

  // Initial Selected Value
  String dropdownvalue = 'Credits';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTransferList();
    getCreditList();
    getPaymentList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   print('Transfer cek: ${_transferList.length}');
          // }),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Credits'),
                Tab(text: 'Transfer'),
                Tab(text: 'Payment'),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                ListView.builder(
                    itemCount: _creditsList.length,
                    itemBuilder: (context, index) {
                      return CreditsCard(_creditsList[index] as Credits);
                    }),
                ListView.builder(
                    itemCount: _transferList.length,
                    itemBuilder: (context, index) {
                      return TransferCard(_transferList[index] as Transfer);
                    }),
                ListView.builder(
                    itemCount: _paymentList.length,
                    itemBuilder: (context, index) {
                      return Text("$index");
                      // return Container(
                      //   child: Column(
                      //     children: [
                      //       Text("data")
                      //     ],
                      //   ),
                      // );
                    })
              ],
            ),
          ),
        ));
  }

  Future getCreditList() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Credits')
        .orderBy('created', descending: true)
        .snapshots()
        .listen((event) {
      _creditsList = List.from(event.docs.map((e) => Credits.fromSnapshot(e)));
    });
    setState(() {
      data;
    });
  }

  Future getTransferList() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Transfer')
        .orderBy('created', descending: true)
        .snapshots()
        .listen((event) {
      _transferList =
          List.from(event.docs.map((e) => Transfer.fromSnapshot(e)));
    });
    setState(() {
      data;
    });
  }

  Future getPaymentList() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Payment')
        .orderBy('created', descending: true)
        .get();
    setState(() {
      _paymentList = List.from(data.docs.map((e) => Payment.fromSnapshot(e)));
    });
  }
}
