import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/models/mess.dart';
import 'package:weather/services/auth.dart';
import 'package:weather/services/database.dart';
import 'package:weather/shared/my_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_form.dart';
import 'mess_list.dart';

class ChatHome extends StatelessWidget {
  ChatHome({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    void _showAddPanel(){
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: AddForm(),
            ),
          );
        },
      );
    }
    return StreamProvider<List<Mess>>.value(
      value: DatabaseService(uid: '').mess,
      initialData: [], // Empty list as initial data
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: Text('Chat box'),
          backgroundColor: Colors.pink[200],
          elevation: 0.0,
          actions: [
            buildIconButton(onPressed: () => _showAddPanel(), icon: Icon(Icons.add_circle), content: 'Add mess'),
            buildIconButton(onPressed: () async => await _auth.signOut(), icon: Icon(Icons.logout_outlined), content: 'Log out'),
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                myConstants.primaryColor ?? Colors.pink,
                myConstants.secondaryColor ?? Colors.deepOrange,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icon/Started.png'),
              )
            ),
            child: messList()
          )
        ),
      ),
    );
  }
}



