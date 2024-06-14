import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/constants.dart';
import '../models/weather/weather_data_daily.dart';
class DailyWeatherWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  DailyWeatherWidget({super.key, required this.weatherDataDaily});

  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day*1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    return Container(
      height: 400,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: myConstants.primaryColor.withOpacity(.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Next day',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: myConstants.textColor,
              ),
            ),
          ),
          DailyList(),
        ],
      ),
    );
  }
  Widget DailyList(){
    Constants myConstants = Constants();
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 7 ? 7 :
        weatherDataDaily.daily.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Container(
                height: 60,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: TextStyle(
                          color: myConstants.textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png'),
                    ),
                    Text(
                      '${weatherDataDaily.daily[index].temp!.min!.toStringAsFixed(1)}° - ${weatherDataDaily.daily[index].temp!.max!.toStringAsFixed(1)}°',
                      style: TextStyle(
                        color: myConstants.textColor
                      )
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 1,
                color: myConstants.secondaryColor.withOpacity(.5),
              )
            ],
          );
        }
      ),
    );
  }
}
