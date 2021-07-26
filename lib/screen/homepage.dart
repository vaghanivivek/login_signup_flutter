//import 'package:ecommerce/screen/login.dart';

import 'package:ecommerce/model/signupmodel.dart';
import 'package:ecommerce/screen/about.dart';
import 'package:ecommerce/screen/contact.dart';
import 'package:ecommerce/screen/login.dart';
import 'package:ecommerce/screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User user;

  bool isloggedin = false;

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    //final googleSignIn = GoogleSignIn();
    //await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    //this.checkAuthentification();
    this.getUser();
  }

  Widget _buildSingleCategory({String image, String title}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 180,
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              //color: Colors.blue,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 95,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/$image.png"),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleFeature({
    context,
    String foodTitle,
    String image,
    foodSubTitle,
    String rating,
    String price,
  }) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: 230,
            width: 210,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  foodTitle,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                Text(
                  foodSubTitle,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[600],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$rating Ratings",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "\$$price",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          maxRadius: 70,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            "images/$image.png",
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureProduct(context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 240,
                      child: Row(
                        children: [
                          _buildSingleFeature(
                            context: context,
                            foodSubTitle: "7 Oceans Hotel",
                            foodTitle: "Pasta Cheese",
                            price: "40",
                            rating: "4.1",
                            image: "pastacheese",
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          _buildSingleFeature(
                            context: context,
                            foodSubTitle: "5 Star Hotel",
                            foodTitle: "Pasta Cheese",
                            price: "50",
                            rating: "5.0",
                            image: "chickenbrost",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPart(context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    icon: Icon(
                      Icons.list,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 120,
                      //color: Colors.blue,
                      child: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 35,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              maxRadius: 30,
                              backgroundImage:
                                  AssetImage("images/profileimage.jpg"),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 250,
                            //color: Colors.blue,
                            child: ListTile(
                              title: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: "Have ",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: "you "),
                                      TextSpan(text: "upset"),
                                    ]),
                              ),
                              subtitle: Text(
                                "Stomatch",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildBottomPart(context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color(0xfff2f3f4),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 240,
                      child: Row(
                        children: [
                          _buildSingleCategory(image: "pizza", title: "Pizza"),
                          _buildSingleCategory(image: "pizza", title: "Pizza"),
                          _buildSingleCategory(image: "pizza", title: "Pizza"),
                          _buildSingleCategory(image: "pizza", title: "Pizza"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "see all",
                    style: TextStyle(
                      fontSize: 23,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildFeatureProduct(context),
          ],
        ),
      ),
    );
  }

  Widget buildMyDrawer(context) {
    return Consumer<MySign>(
      builder: (context, mySign, child) => Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/profileimage.jpg"),
              ),
              accountName: Text("${user.email}"),
              accountEmail: Text("${user.email}"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomePage(),
                  ),
                );
              },
              leading: Icon(
                Icons.home,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Profile"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Contact(),
                  ),
                );
              },
              leading: Icon(
                Icons.contact_phone,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              title: Text("Contact Us"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => About(),
                  ),
                );
              },
              leading: Icon(
                Icons.info,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("About Page"),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Order"),
            ),
            ListTile(
              onTap: () {
                signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Login(),
                  ),
                );
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildMyDrawer(context),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _buildTopPart(context),
              _buildBottomPart(context),
            ],
          ),
        ),
      ),
    );
  }
}
