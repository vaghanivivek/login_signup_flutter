import 'package:flutter/material.dart';

class MySign extends ChangeNotifier {
  String fName;
  String eMail;
  String address;
  var mobile;
  var pass;

  addFname(String fullname) {
    fName = fullname;
    notifyListeners();
  }

  addeMail(String email) {
    eMail = email;
    notifyListeners();
  }

  addAddress(String kaddress) {
    notifyListeners();
  }

  addMobile(var phone) {
    notifyListeners();
  }

  addPass(var apass) {
    notifyListeners();
  }
}
