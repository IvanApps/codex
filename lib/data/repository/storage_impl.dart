import 'dart:convert';
import 'package:appweather/data/repository/storage_city.dart';
import 'package:appweather/model/city_weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyCities = 'cities';
const keyLastUpdate = 'last_update';

class StorageImpl extends StorageCity {
  @override
  Future<List<CityData>> getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(keyCities);
    if (list != null && list.isNotEmpty) {
      final cities = list
          .map(
            (e) => CityData.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
      return cities;
    }
    return <CityData>[];
  }

  @override
  Future<void> saveCity(CityData cityweather) async {
    final list = (await getCities());
    for (CityData item in list) {
      if (item.id == cityweather.id) {
        throw Exception('La ciudad ya existe');
      }
    }
    list.add(cityweather);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      keyCities,
      list.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<void> saveCities(List<CityData> cities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      keyCities,
      cities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<DateTime?> getLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getInt(keyLastUpdate);
    if (data != null && data > 0) {
      return DateTime.fromMillisecondsSinceEpoch(data);
    }
    return null;
  }

  @override
  Future<void> saveLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyLastUpdate, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> deleteCity(CityData city) async {
    final cities = await getCities();
    cities.removeWhere((element) => element.id == city.id);
    saveCities(cities);
  }
}
