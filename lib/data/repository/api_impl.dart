import 'dart:convert';
import 'package:appweather/data/data_constants.dart';
import 'package:appweather/data/repository/api_repository.dart';
import 'package:appweather/model/city_weather.dart';
import 'package:appweather/model/new_city.dart';
import 'package:http/http.dart' as http;

class ApiImpl extends ApiRepository {
  @override
  Future<List<NewCity>> getCities(String text) async {
    List<NewCity> cities = [];
    /*final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();*/
    final url = '$api/weather?q=$text&appid=$apikey&units=metric';
    final response = await http.get(Uri.parse(url));
    //final data = jsonDecode(response.body) as List;
    //final cities = data.map((e) => NewCity.fromJson(e)).toList();
    final data = jsonDecode(response.body);
    cities.add(NewCity.fromJson(data));
    return cities;
  }

  @override
  Future<CityData> getWeathers(NewCity city) async {
    /*final url = '$api${city.id}';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weatherData = data['consolidated_weather'] as List;
    final weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);*/
    final url = '$afser${city.id}$afkey$afsuf';
    final response = await http.get(Uri.parse(url));
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weatherData = jsonEncode(CityWeather.fromJson(data).toJson());
    final newCityWeather = CityData.fromJson(jsonDecode(weatherData));
    return newCityWeather;
  }
}
