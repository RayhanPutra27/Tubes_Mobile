import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IsiPulsaPage extends StatefulWidget {
  @override
  State<IsiPulsaPage> createState() => _IsiPulsaPageState();
}

class _IsiPulsaPageState extends State<IsiPulsaPage> {
  TextEditingController nomorController = TextEditingController();
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(18),
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
                    Text("Masukkan Nomor Tujuan:"),
                    TextField(
                      controller: nomorController,
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
                          if (_nominal[index] == 'Isi Pulsa') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IsiPulsaPage()));
                          }
                          print('item : ${_nominal[index]} Pressed');
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
                    Expanded(child: TextField(
                      controller: nomorController,
                      decoration: InputDecoration(
                          hintText: "Masukkan Manual Nominal (Min. 10.000)"),
                    ),),
                    SizedBox(width: 18,),
                    ElevatedButton(onPressed: () {}, child: Text("Isi"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
