//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screen/signup.dart';
import 'package:ecommerce/widgets/all_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);
  //firbase code
  bool isLoading = false;
  UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on PlatformException catch (e) {
      String message = "Please Check Internet";
      if (e.message != null) {
        message = e.message.toString();
      }
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Email and Password Are Not Match Please Sign up"),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void validation() {
    if (email.text.isEmpty && password.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Email and Password is Empty'),
        ),
      );
    } else if (email.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Email is Empty'),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Email is Not Valid'),
        ),
      );
    } else if (password.text.isEmpty) {
      //(password.text.length < 8)
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Password is Empty'),
        ),
      );
    } else {
      submit();
    }
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffold,
      backgroundColor: Color(0xfff8f8f8),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  LoginText(
                    title: "Login In",
                    subtitle: "Welcome Back",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoginEmailTextField(
                            controller: email,
                            title: "Email",
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          LoginPassField(
                            controller: password,
                            title: "password",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  isLoading == false
                      ? LoginButton(
                          title: "Login",
                          onpressed: () {
                            validation();
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  LoginTapText(
                    title: "Dont't Have Account",
                    buttontitle: "Sign Up",
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
