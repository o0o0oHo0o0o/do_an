import 'package:weather/UI/authenticate/register.dart';
import 'package:weather/UI/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final bool isRegister;
  const Authenticate({required this.isRegister});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isRegister? Register() : SignIn(),
    );
  }
}
