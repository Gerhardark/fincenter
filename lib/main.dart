import 'package:app/pages/new_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/dashboard.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:app/pages/account.dart';
import 'package:app/pages/documents.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:app/pages/advisors.dart';
import 'package:app/pages/courses.dart';
import 'package:app/pages/investing.dart';
import 'package:app/pages/news.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenciasUsuarios.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setUserProperty(name: 'connected', value: 'true');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final prefs = PreferenciasUsuarios();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        theme: ThemeData(
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
          brightness: Brightness.light
        )
        ),
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.ultimaPagina,
      routes: {
        LoginPage.routename: (context) => LoginPage(),
        NewUser.routename: (context) => NewUser(),
        DashBoard.routename: (context) => DashBoard(),
        Account.routename: (context) => Account(),
        Documents.routename: (context) => Documents(),
        Advisors.routename: (context) => Advisors(),
        Courses.routename: (context) => Courses(),
        Investing.routename: (context) => Investing(),
        News.routename: (context) => News(),
      }
    );
  }
}

