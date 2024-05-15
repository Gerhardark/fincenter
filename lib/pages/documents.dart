import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Documents extends StatefulWidget {

  static const String routename = "Documents";
  const Documents({super.key});

  @override
  State<Documents> createState() => _Documents();
}

class _Documents extends State<Documents> {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;
    return Scaffold (
        appBar: AppBar (
          title: Text("Mi Cuenta"),
          centerTitle: true,
        ),
        body: Center (
            child: SingleChildScrollView(
              child: Column (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${currentUser?.email ?? ""}",
                        style: TextStyle(fontSize: 40)),
                  ]
              ),
            )
        )
    );
  }
}