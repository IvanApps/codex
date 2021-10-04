import 'package:appweather/model/city_weather.dart';
import 'package:appweather/model/new_city.dart';

abstract class ApiRepository {
  Future<List<NewCity>> getCities(String text);
  Future<CityData> getWeathers(NewCity city);
}
