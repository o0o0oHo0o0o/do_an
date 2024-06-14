import 'package:flutter/foundation.dart';
import 'package:weather/models/weather/weather.dart';

class Daily{
  int? dt;
  Temp? temp;
  List<Weather>? weather;
  Daily({this.dt, this.temp, this.weather});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: (json['dt'] as int),
    temp: json['temp'] == null? null:
        Temp.fromJson(json['temp'] as Map<String, dynamic>),
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

class Temp{
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;
  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});
  factory Temp.fromJson(Map<String, dynamic> json) =>
      Temp(
        day: (json['day'] as num?)?.toDouble(),
        min: (json['min'] as num?)?.toDouble(),
        max: (json['max'] as num?)?.toDouble(),
        night: (json['night'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
      );
  Map<String, dynamic> toJson() =>{
    'day': day,
    'min': min,
    'max': max,
    'night': night,
    'eve': eve,
    'morn': morn,
  };
}

class WeatherDataDaily{
  List<Daily> daily;
  WeatherDataDaily({required this.daily});
  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(daily: List<Daily>.from(json['daily']
          .map((e)=>Daily.fromJson(e)
      )));
}
