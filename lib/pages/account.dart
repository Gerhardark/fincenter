import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  static const String routename = "Account";
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref('usuarios');
  String name = '';
  String lastNameFather = '';
  String lastNameMother = '';
  String phone = '';
  String rut = '';

  @override
  void initState() {
    super.initState();
    User? currentUser = _auth.currentUser;
    databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;
      setState(() {
        name = snapshot.child(currentUser!.uid).child('name').value.toString();
        lastNameFather = snapshot
            .child(currentUser!.uid)
            .child('lastNameFather')
            .value
            .toString();
        lastNameMother = snapshot
            .child(currentUser!.uid)
            .child('lastNameMother')
            .value
            .toString();
        phone =
            snapshot.child(currentUser!.uid).child('phone').value.toString();
        rut = snapshot.child(currentUser!.uid).child('rut').value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text("Mi Cuenta"),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text("${currentUser?.email ?? ""}",
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.email),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text(
                        name + " " + lastNameFather + " " + lastNameMother),
                    leading: Icon(Icons.person),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text(phone),
                    leading: Icon(Icons.phone),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text(rut),
                    leading: Icon(Icons.credit_card),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
