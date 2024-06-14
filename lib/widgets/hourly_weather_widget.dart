import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/models/weather/weather_data_hourly.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyWeatherWidget({super.key, required this.weatherDataHourly});
  RxInt weatherIndex = GlobalController().getInt();

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,),
          alignment: Alignment.topCenter,
          child: Text("Today", style: TextStyle(
            fontSize: 20, color: myConstants.textColor, fontWeight: FontWeight.w400
          )),
        ),
        hourlyList(),
      ],
    );
  }
  Widget hourlyList(){
    Constants myConstants = Constants();
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12 ? 12 : weatherDataHourly.hourly.length,
        itemBuilder: (context, index){
          return Obx(()=>
            GestureDetector(
              onTap: (){
                weatherIndex.value = index;
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(
                    offset: Offset(0.2, 0),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: myConstants.primaryColor.withOpacity(.25)
                  ),],
                  gradient: (weatherIndex == index) ? LinearGradient(colors: [
                    myConstants.secondaryColor,
                    myConstants.primaryColor
                  ]) : null
                ),
                child: HourlyDetail(
                  check: weatherIndex == index,
                  temp: weatherDataHourly.hourly[index].temp!,
                  time: weatherDataHourly.hourly[index].dt!,
                  weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ),
            )
          );
        }
      ),
    );
  }
}

class HourlyDetail extends StatelessWidget {
  bool check;
  double temp;
  int time;
  String weatherIcon;
  HourlyDetail({super.key, required this.check, required this.temp, required this.time, required this.weatherIcon});

  String getTime(final time){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time*1000);
    String x = DateFormat('jm').format(dateTime);
    return x;
  }
  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top:10),
          child: Text(getTime(time), style: TextStyle(color: check? Colors.white : myConstants.textColor),),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset("assets/weather/${weatherIcon}.png"),
          height: 40,
          width: 40,
        ),
        Container(
          margin: const EdgeInsets.only(bottom:10),
          child: Text('${temp.toStringAsFixed(1)}°', style: TextStyle(color: check? Colors.white : myConstants.textColor)),
        ),
      ],
    );
  }
}
