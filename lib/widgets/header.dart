import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String title , TabBar tabBar}) {

  return AppBar(
    bottom: tabBar,
    title: Text(
      isAppTitle ? 'Patient Talks' : title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Signatra',
        fontSize: isAppTitle ? 50 : 40,
      ),
    ),
    centerTitle: true,
    backgroundColor: isAppTitle ? Colors.red : Colors.blueAccent,
  );
}
