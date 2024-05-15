import 'package:app/pages/new_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  static const String routename = "login";
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController passwordTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 154, 180, 1),
        title: const Text(
          "FINCENTER",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center (
          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Image.asset(
                  'assets/logo_fincenter_square.png',
                  width: 140,
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5.0, // Adjust blur radius as needed
                          spreadRadius: 2.0, // Adjust spread radius as needed
                          offset: Offset(
                            3.0, // Adjust offset as needed
                            3.0, // Adjust offset as needed
                          ),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(24, 154, 180, 1)),
                        ),
                        TextField(
                          controller: emailTextField,
                          cursorColor: Color.fromRGBO(24, 154, 180, 1),
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromRGBO(24, 154, 180, 1)),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              prefixIconColor: Color.fromRGBO(24, 154, 180, 1),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(24, 154, 180, 1)
                              ),
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5.0, // Adjust blur radius as needed
                          spreadRadius: 2.0, // Adjust spread radius as needed
                          offset: Offset(
                            3.0, // Adjust offset as needed
                            3.0, // Adjust offset as needed
                          ),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PIN",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(24, 154, 180, 1)),
                        ),
                        TextField(
                          obscureText: showPassword,
                          controller: passwordTextField,
                          cursorColor: Color.fromRGBO(24, 154, 180, 1),
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromRGBO(24, 154, 180, 1)),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              prefixIconColor: Color.fromRGBO(24, 154, 180, 1),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                ),
                                color: Color.fromRGBO(24, 154, 180, 1),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                              hintText: "PIN",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(24, 154, 180, 1)
                              ),
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  String email = emailTextField.text;
                  String password = passwordTextField.text;

                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('usuario', email);
                    prefs.setString('contrasena', password);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Bienvenido',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Color.fromRGBO(24, 154, 180, 1),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    ); /// Replace with your desired route
                  } on FirebaseAuthException catch (e) {
                    print(e.message);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuario o contraseña incorrecta'),
                      ),
                    );
                  }
                  },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(24, 154, 180, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewUser())
                    );
                    },
                  child: Text(
                    "Crear Cuenta",
                    style: TextStyle(
                        color: Color.fromRGBO(24, 154, 180, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String email = emailTextField.text;

                    try {
                      await _auth.sendPasswordResetEmail(email: email);
                      // Show success message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xff66bb6a),
                          content: Text('Hemos reestablecido tu contraseña, revisa tu email'),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      // Handle errors appropriately
                      switch (e.code) {
                        case 'invalid-email':
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'tiene que ser un mail valido',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          break;
                        case 'user-not-found':
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'El email no tiene una cuenta creada',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          break;
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'debes ingresar un email valido',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                      }
                    } catch (e) {
                      // Handle other unexpected errors
                      print('An unexpected error occurred: $e');
                    }
                  },
                  child: Text(
                    "Olvide mi contraseña",
                    style: TextStyle(
                        color: Color.fromRGBO(24, 154, 180, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
            ],
          )
        ),
      )
    );
  }
}