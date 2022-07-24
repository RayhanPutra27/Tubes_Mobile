import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes_mobile/models/credits.dart';

class CreditsCard extends StatelessWidget {
  final Credits _credits;

  CreditsCard(this._credits, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("Number: ${_credits.dest_number}"),
                  )
                ],
              ),
              Row(
                children: [
                  Text("Nominal: ${_credits.nominal}"),
                  Spacer(),
                  Text(DateFormat.yMd().add_Hm().format(_credits.created!).toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
