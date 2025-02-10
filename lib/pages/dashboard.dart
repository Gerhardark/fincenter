import 'package:app/pages/account.dart';
import 'package:app/pages/documents.dart';
import 'package:app/pages/advisors.dart';
import 'package:app/pages/investing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'courses.dart';
import 'login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'news.dart';

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
    final databaseReference = FirebaseDatabase.instance.ref();

    Future<void> guardarTarea() async {
      try {
        await databaseReference.child('usuarios').child(currentUser!.uid).set({
          'name': 'Gerhard',
          'phone': '56951170549',
          'rut': '18014159-6',
          'lastNameFather': 'Reinike',
          'lastNameMother': 'Seidel',
        });
        print('Tarea guardada correctamente');
      } catch (e) {
        print('Error al guardar la tarea: $e');
      }
    }

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
                    padding: EdgeInsets.only(
                        right: 16.0), // Adjust padding as needed
                    child: Icon(Icons.email,
                        color: Color.fromRGBO(24, 154, 180, 1)),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        right: 16.0), // Adjust padding as needed
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
            Text("hola ${currentUser.uid}"),
            ElevatedButton(
              onPressed: guardarTarea,
              child: Text('Guardar datos'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset('assets/logo_fincenter_square.png'),
              padding: EdgeInsets.only(top: 20, bottom: 20),
            ),
            ListTile(
              title: const Text("Mi cuenta"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()));
              },
            ),
            ListTile(
              title: const Text("Asesoría"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Advisors()));
              },
            ),
            ListTile(
              title: const Text("Documentos"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Documents()));
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } on FirebaseAuthException catch (e) {
                  print(e.message); // Handle errors (e.g., sign-out failed)
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Espacio entre iconos
          children: [
            Column(
              // Para centrar el icono y el texto verticalmente
              mainAxisSize:
                  MainAxisSize.min, // Ajusta el tamaño al mínimo necesario
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DashBoard()));
                  },
                ),
                Text("Inicio",
                    style: TextStyle(fontSize: 11)), // Texto debajo del icono
              ],
            ),
            Column(
              // Para centrar el icono y el texto verticalmente
              mainAxisSize:
                  MainAxisSize.min, // Ajusta el tamaño al mínimo necesario
              children: [
                IconButton(
                  icon: Icon(Icons.school),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Courses()));
                  },
                ),
                Text("Cursos",
                    style: TextStyle(fontSize: 11)), // Texto debajo del icono
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.insights),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Investing()));
                  },
                ),
                Text("Oportunidades", style: TextStyle(fontSize: 11)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.bolt),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => News()));
                  },
                ),
                Text("Noticias", style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
