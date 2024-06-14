import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/models/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    return
        Container(
          color: myConstants.primaryColor,
          child: Center(
            child: SpinKitCubeGrid(
              color: myConstants.secondaryColor,
              size: 50.0,
            ),
          ),
        );
  }
}
