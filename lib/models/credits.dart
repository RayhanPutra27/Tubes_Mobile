class Credits {
  String? dest_number;
  int? nominal;
  DateTime? created;

  Credits();

  Map<String, dynamic> toJson() => {
    'dest number': dest_number,
    'nominal': nominal,
    'created': created
  };

  Credits.fromSnapshot(snapshot)
    : dest_number = snapshot.data()['dest number'],
      nominal = snapshot.data()['nominal'],
      created = snapshot.data()['created'].toDate();
}