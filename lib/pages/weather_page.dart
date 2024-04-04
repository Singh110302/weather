import 'package:flutter/material.dart';
import 'package:weather/weatherservice/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/model/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('8d58076c2a030145f9b7d9723d5be383');
  Weather? _weather;

  // fetch Weather
  _fetchWeather() async {
    // current city
    String cityName = await _weatherService.getCurrentCity();
    // get the weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // Weather Animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    String animationPath;

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        animationPath = 'assets/cloudy.json';
        break;
      case 'rainy':
        animationPath = 'assets/rainy.json';
        break;
      case 'thunder':
        animationPath = 'assets/rain.json';
        break;
      default:
        animationPath = 'assets/sunny.json'; // Default value for unknown conditions
    }

    return animationPath;
  }

  // initState
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temprature.round()}~c'),
            // Weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
