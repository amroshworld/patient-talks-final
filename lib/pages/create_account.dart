import 'package:flutter/material.dart';
import 'package:patienttalks/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext parentContext) {
    final _formkey = GlobalKey<FormState>();
    String username;

    submit() {
      _formkey.currentState.save();
      Navigator.pop(context, username);
    }

    return Scaffold(
      appBar: header(context, title: 'Set up your profile'),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Text('create user name',
                        style: TextStyle(
                          fontSize: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    child: Form(
                      key: _formkey,
                      child: TextFormField(
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            labelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            hintText: 'Must be at least 3 characters'),
                      ),
                    ),
                  ),
                ),
                GestureDetector(

                  onTap: submit,
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        'Submit ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
