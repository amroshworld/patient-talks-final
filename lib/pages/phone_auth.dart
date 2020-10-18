import 'package:flutter/material.dart';


class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
//  FirebasePhoneAuthAPI phoneAuthAPI = FirebasePhoneAuthAPI();
//  String code ;
//
//
//  signIn() {
//    phoneAuthAPI.verifyNumber('00201007172861',
//        codeAutoRetrievalTimeout: (dede) => print(dede),
//        signInOnAutoRetrieval: true,
//        timeoutSeconds: 30, codeSent: (code, [int]) {
//      print(code);
//
//    }, verificationCompleted: (authCredential) {
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => Home(),
//        ),
//      );
//    },
//    verificationFailed: (faild) => print(faild));
//    phoneAuthAPI.submitVerificationCode(code);
//    phoneAuthAPI.signIn();
//  }
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    signIn();
//  }
  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}
