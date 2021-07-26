//import 'package:ecommerce/screen/login.dart';
import 'package:ecommerce/model/signupmodel.dart';
import 'package:ecommerce/screen/homepage.dart';
import 'package:ecommerce/screen/login.dart';
//import 'package:ecommerce/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:ecommerce/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MySign>(
      create: (_) => MySign(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          accentColor: Color(0xff04d4ee),
        ),
        home: StreamBuilder<Object>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return Login();
              }
            }),
      ),
    );
  }
}
