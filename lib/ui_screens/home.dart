import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/constants.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static String apiKey = "41ac78f79f824ec7820164414231406";

  Constants myConstants = Constants();

  String location = 'London';
  String weatherIcon = 'heavycloud.png';
  int temperature = 0 ;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = '';

  String searchWeatherAPI = "http://api.weatherapi.com/v1/forecast.json?key=" + apiKey + " &days=7&q= ";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult = await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
        json.decode(searchResult.body) ?? 'No Data');

      var locationData = weatherData['location'];
      var currentWeather = weatherData['current'];

      setState(() {
        location = getShortLocationName(locationData['name']);
        var parsedDate = DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        currentWeatherStatus = currentWeather["condition"]["text"];
        weatherIcon = currentWeatherStatus.replaceAll(' ', ' ').toLowerCase() + ".png";
        temperature = currentWeather["temp_c"].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather["humidity"].toInt();
        cloud = currentWeather["cloud"].toInt();

        dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
        // print(dailyWeatherForecast);

      });
    } catch(e){
     // debugprint(e)
    }
  }

  static String getShortLocationName(String s){
    List<String> wordList = s.split(" ");

    if(wordList.isNotEmpty){
      if(wordList.length>1){
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  // var selectedCities = City.getSelectedCities();
  // List<String> cities = ['London'];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 70,left: 10, right: 10),
        color: myConstants.primaryColor.withOpacity(.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              height: size.height* .7,
              decoration: BoxDecoration(
                gradient: myConstants.linearGradientBlue,
                boxShadow: [
                  BoxShadow(color: myConstants.primaryColor.withOpacity(.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0,3),

                )],
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
