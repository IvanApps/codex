import 'package:appweather/model/city_weather.dart';

abstract class StorageCity {
  Future<void> saveCity(CityData cityweather);
  Future<void> saveCities(List<CityData> cities);
  Future<List<CityData>> getCities();
  Future<DateTime?> getLastUpdate();
  Future<void> saveLastUpdate();
  Future<void> deleteCity(CityData city);
}
