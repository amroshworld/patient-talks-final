import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patienttalks/pages/activity_feed.dart';
import 'package:patienttalks/pages/create_account.dart';
import 'package:patienttalks/pages/profile.dart';
import 'package:patienttalks/pages/search.dart';
import 'package:patienttalks/pages/timeline.dart';
import 'package:patienttalks/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patienttalks/assestants/home_s.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:patienttalks/models/user.dart';

final googleSignIn = GoogleSignIn();
final usersRef = Firestore.instance.collection('users');
final timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  createUserInFirestore() async {
    //check if user exit in collection to database
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();
    //if doesn't exit take them to create account page
    if (!doc.exists) {
     
      final username = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateAccount()),
      );
     usersRef.document(user.id).setData({
        'id': user.id,
        'username' : username,
        'photoUrl': user.photoUrl,
        'email': user.email,
        'displayName': user.displayName,
        'bio': '',
        'timestamp': timestamp
      },);
      doc  = await usersRef.document(user.id).get();
    }
   currentUser  = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
    
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(
        () {
          isAuth = false;
        },
      );
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChange(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChange,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
        //  Timeline(),
          RaisedButton(
            child: Text('logout'),
            onPressed: logout,
          ),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Timeline'),
              activeColor: Colors.red,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text('Activity'),
              activeColor: Colors.purple,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: Icon(
                Icons.add,
              ),
              title: Text('Ask'),
              activeColor: Colors.green,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            activeColor: Colors.orange,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Colors.blueAccent,
              textAlign: TextAlign.center),
        ],
        containerHeight: 65,
        iconSize: 30,
        onItemSelected: onTap,
        selectedIndex: pageIndex,
        showElevation: true,
        itemCornerRadius: 19,
        curve: Curves.easeInCubic,
      ),
    );
  }

  @override
  void initState() {
    
    super.initState();
    pageController = PageController();

    googleSignIn.onCurrentUserChanged.listen(
      (account) {
        handleSignIn(account);
      },
      onError: (err) {
        print(err);
      },
    );

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuth
        ? buildAuthScreen()
        : BuildUnAuthScreen(
            login: login,
          );
  }
}
