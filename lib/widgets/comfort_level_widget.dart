import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/models/weather/weather_data_current.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ComfortLevelWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComfortLevelWidget({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 20, left: 20, right: 20),
          child: Text(
            'Comfort level',
            style: TextStyle(color: myConstants.textColor, fontSize: 20
            ),
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                    infoProperties: InfoProperties(
                      bottomLabelText: "Humidity",
                      bottomLabelStyle: TextStyle(
                        letterSpacing: 0.1, fontSize: 16,height: 1.5
                      ),
                    ),
                    animationEnabled: true,
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: myConstants.primaryColor,
                      progressBarColor: myConstants.secondaryColor
                    )
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text:TextSpan(
                  text: 'Feels likes: ',
                  style: TextStyle(
                    fontSize: 16, height: 0.8, color: myConstants.textColor, fontWeight: FontWeight.w400
                  )
                ),
              ),
              RichText(
                text:TextSpan(
                    text: '${weatherDataCurrent.current.feelsLike}°',
                    style: TextStyle(
                        fontSize: 16, height: 0.8, color: myConstants.textColor, fontWeight: FontWeight.w400
                    )
                ),
              ),
              Container(
                width: 1,
                height: 25,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                color: myConstants.secondaryColor.withOpacity(.3),
              ),
              RichText(
                text:TextSpan(
                    text: 'UV index: ',
                    style: TextStyle(
                        fontSize: 16, height: 0.8, color: myConstants.textColor, fontWeight: FontWeight.w400
                    )
                ),
              ),
              RichText(
                text:TextSpan(
                    text: '${weatherDataCurrent.current.uvIndex}',
                    style: TextStyle(
                        fontSize: 16, height: 0.8, color: myConstants.textColor, fontWeight: FontWeight.w400
                    )
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
