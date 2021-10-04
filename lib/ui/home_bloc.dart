import 'package:appweather/model/new_city.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appweather/data/repository/api_repository.dart';
import 'package:appweather/data/repository/storage_city.dart';
import 'package:appweather/model/city_weather.dart';

class HomeBloc extends ChangeNotifier {
  List<CityData> cities = [];
  final StorageCity storage;
  final ApiRepository apiService;
  bool loading = false;

  HomeBloc({
    required this.storage,
    required this.apiService,
  });

  final formatDate = DateFormat('dd/MM/yyyy HH');

  void loadCities() async {
    final lastUpdate = await storage.getLastUpdate();
    final now = DateTime.now();
    final localCities = await storage.getCities();
    if (localCities.isEmpty) return;
    if (lastUpdate == null ||
        (formatDate.format(now) != formatDate.format(lastUpdate))) {
      List<CityData> citiesUpdated = [];
      loading = true;
      notifyListeners();
      for (CityData city in localCities) {
        final myCity = NewCity.fromJson(city.toJson());
        final cityUpdated = await apiService.getWeathers(myCity);
        citiesUpdated.add(cityUpdated);
      }
      await storage.saveCities(citiesUpdated);
      await storage.saveLastUpdate();
      cities = citiesUpdated;
      loading = false;
    } else {
      cities = await storage.getCities();
    }
    notifyListeners();
  }
}
