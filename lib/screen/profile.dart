import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screen/login.dart';
import 'package:ecommerce/screen/signup.dart';
import 'package:ecommerce/widgets/all_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uname;
  var unumber;
  var uadd;
  var uemail;
  var ugen;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var firestoreDb =
      FirebaseFirestore.instance.collection("UserData").snapshots();
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

  User user;
  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firestoreDb,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, int index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                var docId = ds["UserId"];
                if (ds["UserEmail"] == user.email) {
                  uname = ds["UserName"];
                  uemail = ds["UserEmail"];
                  unumber = ds["UserNumber"];
                  uadd = ds["UserAddress"];
                  ugen = ds["UserGender"];
                }
                return showData(context);

                // return Text(snapshot.data.documents[index]['description']);
              });
        },
      ),
    );
  }

  Container showData(BuildContext context) {
    return Container(
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
                        //
                        //validation();
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
    );
  }
}
