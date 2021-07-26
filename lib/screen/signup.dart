import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screen/homepage.dart';
import 'package:ecommerce/screen/login.dart';
import 'package:ecommerce/widgets/all_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isMale = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);

  //firebase Code
  bool isLoading = false;
  UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } on PlatformException catch (e) {
      String message = "Please Check Internet";
      if (e.message != null) {
        message = e.message.toString();
      }
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(authResult.user.uid)
        .set({
      "UserName": fullName.text,
      "UserEmail": email.text,
      "UserId": authResult.user.uid,
      "UserNumber": mobile.text,
      "UserAddress": address.text,
      "UserGender": isMale == true ? "Male" : "Female",
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  void validation() {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        fullName.text.isEmpty &&
        mobile.text.isEmpty &&
        address.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('All Field  is Empty'),
        ),
      );
    } else if (fullName.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Full Name is Empty'),
        ),
      );
    } else if (email.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Full Name is Empty'),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Email is Not Valid'),
        ),
      );
    } else if (address.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Address is Empty'),
        ),
      );
    } else if (mobile.text.isEmpty) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Mobile Number is Empty'),
        ),
      );
    } else if (mobile.text.length < 10) {
      // ignore: deprecated_member_use
      scaffold.currentState.showSnackBar(
        const SnackBar(
          content: Text('Mobile Number muxt 10 digit'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffold,
      backgroundColor: Color(0xfff8f8f8),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ListView(
          children: [
            Column(
              children: [
                LoginText(
                  title: "Sign Up",
                  subtitle: "Create An Account",
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
                          controller: fullName,
                          title: "Full Name",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoginEmailTextField(
                          controller: email,
                          title: "Email Address",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoginEmailTextField(
                          controller: mobile,
                          title: "Phone Number",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoginEmailTextField(
                          controller: address,
                          title: "Address",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //
                        //GenderButton(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMale = !isMale;
                            });
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isMale ? "FeMale" : "Male",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xfff5d8e4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        LoginPassField(
                          controller: password,
                          title: "Password",
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
                        title: "SignUp",
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
                  title: "You have alredy Account",
                  buttontitle: "Login",
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
