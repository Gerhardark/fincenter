import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';


class NewUser extends StatefulWidget {


  static const String routename = "New_User";
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUser();
}

class _NewUser extends State<NewUser> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool showPassword = true;

  crearUser() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff66bb6a),
          content: Text('Usuario Creado exitosamente.'),
        ),
      );
      Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => LoginPage())
      );

      // Handle successful user creation (e.g., show a success message or redirect)
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'La contraseña es muy simple',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromRGBO(24, 154, 180, 1),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email ya tiene una cuenta creada',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromRGBO(24, 154, 180, 1),
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'La contraseña debe ser de al menos 6 caracteres',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      // Handle other potential errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color.fromRGBO(24, 154, 180, 1),
        title: const Text(
          "Nuevo Usuario",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(15),
                child: Image.asset(
                  'assets/sign_up.png',
                  width: 260,
                ),
              ),
              SizedBox(height: 20),
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
                          controller: email,
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
              SizedBox(height: 20),
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
                          controller: pass,
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
              SizedBox(height: 20),
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
                child: ElevatedButton(
                    onPressed: crearUser,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Text(
                        "Crear Usuarios",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(24, 154, 180, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}


