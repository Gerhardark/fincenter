import 'package:app/pages/account.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class DashBoard extends StatefulWidget {

  static const String routename = "DashBoard";
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Página Principal"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              null;
            },
            child: currentUser!.emailVerified
                  ? Padding(
                      padding: EdgeInsets.only(right: 16.0), // Adjust padding as needed
                      child: Icon(Icons.email, color: Color.fromRGBO(24, 154, 180, 1)),
                    )
                  : Padding(
                      padding: EdgeInsets.only(right: 16.0), // Adjust padding as needed
                      child: Icon(Icons.email, color: Colors.redAccent),
                    ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("hola ${currentUser.email ?? ""}"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset('assets/logo_fincenter_square.png'),
              padding: EdgeInsets.only(top: 20, bottom:20),
            ),
            ListTile(
              title: const Text("Mi cuenta"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Account())
                );
              },
            ),
            ListTile(
              title: const Text("Documentos"),
              onTap: () {
                null;
              },
            ),
            ListTile(
              title: Text("Cerrar Sesión"),
              trailing: Icon(Icons.logout),
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () async {
                try {
                  await _auth.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Has cerrado sesión correctamente.',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage())
                  );
                } on FirebaseAuthException catch (e) {
                  print(e.message); // Handle errors (e.g., sign-out failed)
                }
              },
            ),
          ],
        ),
      )
    );
  }
}