import 'package:flutter/foundation.dart';
import 'package:weather/models/weather/weather.dart';

class Current{
  double? temp;
  int? humidity;
  int? cloud;
  double? uvIndex;
  double? feelsLike;
  double? windSpeed;
  List<Weather>? weather;
  Current({this.temp, this.humidity, this.cloud,this.uvIndex, this.feelsLike, this.windSpeed,this.weather});

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    temp: (json['temp'] as num?)?.toDouble(),
    humidity: json['humidity'] as int?,
    cloud: json['clouds'] as int?,
    uvIndex: (json['uvi'] as num?)?.toDouble(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
      ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
      .toList(),
  );
  Map <String,dynamic> toJson() =>{
    'temp': temp,
    'humidity': humidity,
    'cloud': cloud,
    'uvi': uvIndex,
    'feels_like': feelsLike,
    'windSpeed': windSpeed,
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class WeatherDataCurrent{
  final Current current;
  WeatherDataCurrent({required this.current});
  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json['current']));
}
