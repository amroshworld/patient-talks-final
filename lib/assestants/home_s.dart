import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:patienttalks/pages/phone_auth.dart';

class BuildUnAuthScreen extends StatelessWidget {
  BuildUnAuthScreen({this.login});
  final Function login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Patient Talks',
                style: TextStyle(
                  fontFamily: "Signatra",
                  fontSize: 90,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                width: 260.0,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SignInButtonBuilder(
                fontSize: 18,
                padding: EdgeInsets.all(20),
                height: 60,
                width: 210,
                backgroundColor: Colors.blue[600],
                text: 'sign in with phone ',
                icon: Icons.phone,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneAuth()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
