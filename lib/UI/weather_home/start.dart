import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/UI/weather_home/weather_home_screen.dart';
import 'package:weather/UI/weather_home/welcome.dart';
import 'package:weather/UI/wrapper.dart';
import 'package:weather/models/constants.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myConstants.primaryColor.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icon/Started.png'),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Wrapper(isRegister: false)));
                },
                child: Container(
                  height: 50,
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                    color: myConstants.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(
                    child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
