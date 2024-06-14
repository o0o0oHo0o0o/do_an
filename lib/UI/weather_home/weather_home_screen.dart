import 'package:flutter/material.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/widgets/current_weather_widget.dart';
import 'package:weather/models/weather/weather_data.dart';
import 'package:weather/widgets/loading.dart';
import 'package:weather/widgets/comfort_level_widget.dart';
import 'package:weather/widgets/daily_weather_widget.dart';
import 'package:weather/widgets/header_widget.dart';
import 'package:weather/widgets/hourly_weather_widget.dart';

import '../../services/auth.dart';
import '../../shared/my_style.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  //call
  Constants myConstants = Constants();
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather-chat', style: TextStyle(color: Colors.white),),
        backgroundColor: myConstants.primaryColor.withOpacity(.75),
        elevation: 0.0,
        actions: [
          buildIconButton(onPressed: () async => await _auth.signOut(), icon: Icon(Icons.logout_outlined), content: 'Log out'),
        ],
      ),
      body: SafeArea(
        child: Obx(()=>
          globalController.checkLoading().isTrue
          ? Loading()
          : Container(
            color: myConstants.secondaryColor.withOpacity(.25),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 20,),
                HeaderWidget(),
                //  current temp
                CurrentWeatherWidget(
                  weatherDataCurrent: globalController.getWeatherData().getCurrentWeather(),
                ),
                SizedBox(height: 20,),
                HourlyWeatherWidget(
                  weatherDataHourly: globalController.getWeatherData().getHourlyWeather(),
                ),
                SizedBox(height: 20,),
                DailyWeatherWidget(
                  weatherDataDaily: globalController.getWeatherData().getDailyWeather(),
                ),
                SizedBox(height: 10,),
                Container(height: 1, color: myConstants.secondaryColor.withOpacity(.5),),
                SizedBox(height: 10,),
                ComfortLevelWidget(
                  weatherDataCurrent: globalController.getWeatherData().getCurrentWeather(),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
