import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TextEditingController _bankController = TextEditingController();

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
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Bank Tujuan:',
                          ),
                          controller: _bankController,
                        )),
                    Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('asd'),
                        ))
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'No Rekening Tujuan:',
                          ),
                          controller: _bankController,
                        )),
                  ],
                )),
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 8,
                          child: Text(
                            'Rekening Ditemukan',
                          )),
                      Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('cek'),
                          ))
                    ],
                  )),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('Masukkan Nominal:')),
                            Expanded(
                                child: TextFormField(
                              decoration: InputDecoration(hintText: '00000000'),
                              controller: _bankController,
                            )),
                          ],
                        )),
                  ],
                )),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    )
                  ],
                )),
            Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Transfer'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
