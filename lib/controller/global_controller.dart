import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/api/fetch_weather.dart';

import '../models/weather/weather_data.dart';
class GlobalController extends GetxController{
  //create variuos value
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _curIndex = 0.obs;
  final RxBool _isPasswordVisibility = true.obs;
  final RxBool _isRePasswordVisibility = true.obs;

  get isPasswordVisibility => _isPasswordVisibility;
  get isRePasswordVisibility => _isRePasswordVisibility;
  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  RxInt getInt() => _curIndex;

  final weatherData = WeatherData().obs;
  getWeatherData() => weatherData.value;
  @override
  void onInit() {
    // TODO: implement onInit
    if(_isLoading.isTrue){
      getLocation();
    } else{
      getInt();
    }
    super.onInit();
  }

  getLocation() async{
    bool isServiceEnabled;
    LocationPermission locationPermission;
    //service enabled
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnabled){
      return Future.error('Location not enable');
    }
    //permission
    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.deniedForever){
      return Future.error('Location permission is denied forever');
    }
    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied){
        return Future.error('Location permission is denied');
      }
    }
    //get the currentposition
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value){
          _longitude.value = value.longitude;
          _lattitude.value = value.latitude;
          //api
        return FetchWeatherAPI().processData(value.latitude, value.longitude)
        .then((value){
          weatherData.value = value;
          _isLoading.value = false;
        });
    });
  }
}