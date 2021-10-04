import 'weathers.dart';

class CityWeather {
  final int id;
  final String name;
  List<WeatherData> dayElements = [];

  CityWeather({
    required this.id,
    required this.name,
    required this.dayElements,
  });

  factory CityWeather.fromJson(Map<String, dynamic> map) {
    final cityJson = map['city'];
    final mapWeathers = map['list'];
    return CityWeather(
      id: City.fromJson(cityJson).id,
      name: City.fromJson(cityJson).name,
      dayElements:
          (mapWeathers as List).map((e) => WeatherData.fromJson(e)).toList(),
    );
  }
/*
  factory CityWeather.fromJson(Map<String, dynamic> json) {
    //final cityJson = json['city'];
    final mapWeathers = json['list'];
    //final listJson = json['list'];
    //print(listJson.toString());
    return CityWeather(
      //id: City.fromJson(cityJson).id,
      //name: City.fromJson(cityJson).name,
      id: json['id'],
      name: json['name'],
      dayElements:
          (mapWeathers as List).map((e) => WeatherData.fromJson(e)).toList(),
    );
  }
*/
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dayElements": dayElements.map((e) => e.toJson()).toList(),
      };
}

class WeatherData {
  final double temp;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int id;
  final String main;
  final String description;
  final String icon;
  final double speed;
  final String dttxt;

  WeatherData({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.speed,
    required this.dttxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final myMain = json['main'];
    final myWeather = json['weather'][0];
    final myWind = json['wind'];
    return WeatherData(
      temp: MainClass.fromJson(myMain).temp,
      tempMin: MainClass.fromJson(myMain).tempMin,
      tempMax: MainClass.fromJson(myMain).tempMax,
      pressure: MainClass.fromJson(myMain).pressure,
      humidity: MainClass.fromJson(myMain).humidity,
      id: Weather.fromJson(myWeather).id,
      main: Weather.fromJson(myWeather).main,
      description: Weather.fromJson(myWeather).description,
      icon: Weather.fromJson(myWeather).icon,
      speed: Wind.fromJson(myWind).speed,
      dttxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "tempMin": tempMin,
        "tempMax": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
        "speed": speed,
        "dt_txt": dttxt,
      };
}

class CityData {
  final int id;
  final String name;
  List<ListWeather> dayElements = [];

  CityData({required this.id, required this.name, required this.dayElements});

  factory CityData.fromJson(Map<String, dynamic> map) {
    final listweather = map['dayElements'];
    return CityData(
      id: map['id'],
      name: map['name'],
      dayElements:
          (listweather as List).map((e) => ListWeather.fromJson(e)).toList(),
    );
  }

  factory CityData.fromCity(Map<String, dynamic> map) {
    //final listweather = map['dayElements'];
    return CityData(
      id: map['id'],
      name: map['name'],
      dayElements: <ListWeather>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dayElements": dayElements.map((e) => e.toJson()).toList(),
      };
}

class ListWeather {
  final double temp;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int id;
  final String main;
  final String description;
  final String icon;
  final double speed;
  final String dttxt;

  ListWeather({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.speed,
    required this.dttxt,
  });

  factory ListWeather.fromJson(Map<String, dynamic> json) {
    return ListWeather(
      temp: json['temp'],
      tempMin: json['tempMin'],
      tempMax: json['tempMax'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
      speed: json['speed'],
      dttxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "tempMin": tempMin,
        "tempMax": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
        "speed": speed,
        "dt_txt": dttxt,
      };
}
