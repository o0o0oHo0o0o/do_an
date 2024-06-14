import 'package:weather/UI/MyPageView.dart';
import 'package:weather/UI/weather_home/weather_home_screen.dart';
import 'package:weather/UI/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/my_user.dart';
import 'authenticate/authenticate.dart';
import 'chat_home/chat_home.dart';

class Wrapper extends StatelessWidget {
  final bool isRegister;
  const Wrapper({required this.isRegister});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user?.uid);
    if(user == null){
      print("Nullllllllllllllllllll");
      return Authenticate(isRegister: this.isRegister,);
    } else {
      print("No Nullllll");
      return MyPageView();
    }
  }
}
