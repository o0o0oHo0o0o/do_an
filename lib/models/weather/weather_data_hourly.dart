import 'package:flutter/foundation.dart';
import 'package:weather/models/weather/weather.dart';

class Hourly{
  int? dt;
  double? temp;
  List<Weather>? weather;
  Hourly({this.dt, this.temp, this.weather});

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    dt: (json['dt'] as int),
    temp: (json['temp'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  Map <String,dynamic> toJson() =>{
    'dt': dt,
    'temp': temp,
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class WeatherDataHourly{
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});
  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(hourly: List<Hourly>.from(json['hourly']
          .map((e)=>Hourly.fromJson(e)
      )));
}
