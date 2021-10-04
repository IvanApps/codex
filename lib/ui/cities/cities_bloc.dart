import 'package:appweather/model/city_weather.dart';
import 'package:flutter/material.dart';
import 'package:appweather/data/repository/storage_city.dart';

class CitiesBloc extends ChangeNotifier {
  List<CityData> cities = [];
  final StorageCity storage;

  CitiesBloc({
    required this.storage,
  });

  void loadCities() async {
    cities = await storage.getCities();
    notifyListeners();
  }

  void deleteCity(CityData city) async {
    await storage.deleteCity(city);
    loadCities();
  }
}
