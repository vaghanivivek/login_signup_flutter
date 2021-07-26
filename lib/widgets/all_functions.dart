import 'package:ecommerce/model/signupmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
//import 'package:ecommerce/model/signupmodel.dart';

//import 'package:ecommerce/screen/signup.dart';
//import 'package:ecommerce/screen/login.dart';

class LoginText extends StatelessWidget {
  final String title, subtitle;

  LoginText({this.title, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //color: Colors.blue,
      height: 150,
      width: double.infinity,
      //padding: EdgeInsets.symmetric(horizontal: 00, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).primaryColor,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  LoginEmailTextField({this.controller, this.title});
  @override
  Widget build(BuildContext context) {
    return Consumer<MySign>(
      builder: (context, mySign, child) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Color(0xfff5d8e4),
          filled: true,
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (var value) {
          if (title == "Full Name") {
            mySign.addFname(value);
          } else if (title == "Email Address") {
            mySign.addeMail(value);
          } else if (title == "Phone Number") {
            mySign.addMobile(value);
          } else if (title == "Address") {
            mySign.addAddress(value);
          }
        },
      ),
    );
  }
}

class LoginPassField extends StatefulWidget {
  final TextEditingController controller;
  final String title;

  LoginPassField({this.controller, this.title});

  @override
  _LoginPassFieldState createState() => _LoginPassFieldState();
}

class _LoginPassFieldState extends State<LoginPassField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<MySign>(
      builder: (context, mySign, child) => TextFormField(
        onChanged: (var value) {
          mySign.addPass(value);
        },
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child:
                  Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            ),
            fillColor: Color(0xfff5d8e4),
            filled: true,
            hintText: widget.title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String title;
  final Function onpressed;
  LoginButton({this.title, this.onpressed});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Container(
        height: 70,
        width: double.infinity,
        // ignore: deprecated_member_use
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).primaryColor,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          onPressed: onpressed,
        ));
  }
}

class GenderButton extends StatefulWidget {
  final bool isMale;
  final Function onTap;
  GenderButton({this.isMale, this.onTap});
  @override
  _GenderButtonState createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.isMale ? "FeMale" : "Male",
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
    );
  }
}

class LoginTapText extends StatelessWidget {
  final String title;
  final String buttontitle;
  final Function onTap;

  LoginTapText({this.title, this.buttontitle, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        InkWell(
          child: Text(
            buttontitle,
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          ),
          onTap: onTap,
        )
      ],
    );
  }
}
