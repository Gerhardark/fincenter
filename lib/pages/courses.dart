import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Courses extends StatefulWidget {

  static const String routename = "Courses";
  const Courses({super.key});

  @override
  State<Courses> createState() => _Courses();
}

class _Courses extends State<Courses> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref('usuarios');
  String nombre = '';
  String description = '';
  String likes = '';

  @override
  void initState() {
    super.initState();
    User? currentUser = _auth.currentUser;
    databaseReference.onValue.listen((event) {
      final snapshot = event.snapshot;
      setState(() {
        nombre = snapshot.child(currentUser!.uid).child('Tittle').value.toString();
        description = snapshot.child(currentUser!.uid).child('Description').value.toString();
        likes = snapshot.child(currentUser!.uid).child('likes').value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold (
        appBar: AppBar (
          title: Text("Cursos"),
          centerTitle: true,
        ),
        body: Center (
            child: SingleChildScrollView(
              child: Column (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(nombre),
                    Text(description),
                    Text(likes)
                  ],
              ),
            )
        )
    );
  }
}