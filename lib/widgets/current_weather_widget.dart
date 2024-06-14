import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/models/weather/weather_data_current.dart';

class CurrentWeatherWidget extends StatelessWidget {
  CurrentWeatherWidget({super.key, required this.weatherDataCurrent});
  final WeatherDataCurrent weatherDataCurrent;
  final Constants myConstants = Constants();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //temps area
        TemperatureWidget(),
        SizedBox(height: 15,),
        //windspeed_humidity_clouds
        currentWeatherDetailsWidget(),
      ],
    );
  }
  Widget TemperatureWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 90, width: 90,
        ),
        Container(height: 50, width: 1),
        RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${weatherDataCurrent.current.temp!.toStringAsFixed(1)}°",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 55,
                      color: myConstants.textColor
                  )
                ),
                TextSpan(
                    text: "${weatherDataCurrent.current.weather![0].description}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: myConstants.textColor
                    )
                ),
              ],
            ),
        )
      ],
    );
  }
  Widget currentWeatherDetailsWidget(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: myConstants.primaryColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/icon/windspeed.png'),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: myConstants.primaryColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/icon/heavycloudy.png'),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: myConstants.primaryColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/icon/humidity.png'),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.windSpeed!.toStringAsFixed(1)} km/h",
                style: TextStyle(fontSize: 14, color: myConstants.textColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.cloud} %",
                style: TextStyle(fontSize: 14, color: myConstants.textColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.humidity} %",
                style: TextStyle(fontSize: 14, color: myConstants.textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}

