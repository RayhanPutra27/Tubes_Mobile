import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes_mobile/models/credits.dart';
import 'package:tubes_mobile/models/transfers.dart';

class TransferCard extends StatelessWidget {
  final Transfer _transfer;

  TransferCard(this._transfer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("Destination: ${_transfer.dest_acc}"),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("Bank: ${_transfer.dest_bank}"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Nominal: ${_transfer.nominal}"),
                  Spacer(),
                  Text(DateFormat.yMd().add_Hm().format(_transfer.created!).toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
