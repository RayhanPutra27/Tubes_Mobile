class Transfer {
  int? dest_acc;
  String? dest_bank;
  int? nominal;
  DateTime? created;

  Transfer();

  Map<String, dynamic> toJson() => {
    'dest acc': dest_acc,
    'dest bank': dest_bank,
    'nominal': nominal,
    'created': created
  };

  Transfer.fromSnapshot(snapshot)
    : dest_acc = snapshot.data()['dest acc'],
      dest_bank = snapshot.data()['dest bank'],
      nominal = snapshot.data()['nominal'],
      created = snapshot.data()['created'].toDate();
}