import 'package:flutter/material.dart';

class WeatherForecast {
  DateTime? date;
  double? temp;
  String? weatherDescription;
  IconData? weatherIcon;
  double? minTemp;
  double? maxTemp;

  WeatherForecast({
    this.date,
    this.temp,
    this.weatherDescription,
    this.weatherIcon,
    this.minTemp,
    this.maxTemp,
  });

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    date = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000, isUtc: false);
    temp = json["main"]["temp"].toDouble();
    weatherDescription = json["weather"][0]["description"];
    weatherIcon = getWeatherIconForCondition(json["weather"][0]["id"]);
    minTemp = json["main"]["temp_min"].toDouble();
    maxTemp = json["main"]["temp_max"].toDouble();
  }
  IconData getWeatherIconForCondition(int conditionCode) {
    if (conditionCode < 300) {
      return Icons.cloud;
    } else if (conditionCode < 600) {
      return Icons.beach_access;
    } else if (conditionCode < 700) {
      return Icons.ac_unit;
    } else if (conditionCode < 800) {
      return Icons.cloud_queue;
    } else if (conditionCode == 800) {
      return Icons.wb_sunny;
    } else if (conditionCode <= 804) {
      return Icons.cloud;
    } else {
      return Icons.help;
    }
  }
}
