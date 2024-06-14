import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather/weather_data.dart';
import 'package:weather/models/weather/weather_data_current.dart';
import 'package:weather/models/weather/weather_data_daily.dart';
import 'package:weather/models/weather/weather_data_hourly.dart';
import '../utils/api_url.dart';
import 'api_key.dart';

class FetchWeatherAPI{
  WeatherData? weatherData;
  // processing from response -> json
  Future<WeatherData> processData(double lat, double lon) async {
    // Đảm bảo http không null bằng cách sử dụng http từ gói đã import
    var response = await http.get(Uri.parse(apiURL(lat, lon)));

    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      weatherData = WeatherData(current: WeatherDataCurrent.fromJson(jsonString),
          hourly: WeatherDataHourly.fromJson(jsonString), daily: WeatherDataDaily.fromJson(jsonString));
      return weatherData!;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

