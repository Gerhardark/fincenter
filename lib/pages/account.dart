import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {

  static const String routename = "Account";
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {

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