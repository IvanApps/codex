//import 'package:example/ui/common/debouncer.dart';

import 'package:appweather/data/repository/api_repository.dart';
import 'package:appweather/data/repository/storage_city.dart';
import 'package:appweather/model/new_city.dart';
import 'package:flutter/material.dart';

class AddCityBloc extends ChangeNotifier {
  //final debouncer = Debouncer();
  final StorageCity storage;
  final ApiRepository apiService;

  List<NewCity> cities = [];
  bool loading = false;
  String errorMessage = ' ';
  final fieldTextCon = TextEditingController();

  AddCityBloc({
    required this.storage,
    required this.apiService,
  });

  //void onChangedText(String text) {
  //  debouncer.run(() {});
  //}

  void onSubmitted(String text) {
    if (text.isNotEmpty) requestSearch(text);
  }

  void clearText() {
    fieldTextCon.clear();
  }

  void requestSearch(String text) async {
    loading = true;
    notifyListeners();

    cities = await apiService.getCities(text);

    clearText();
    loading = false;
    notifyListeners();
  }

  Future<bool> addCity(NewCity city) async {
    loading = true;
    notifyListeners();

    final newCity = await apiService.getWeathers(city);
    try {
      await storage.saveCity(newCity);
      errorMessage = 'X';
      return true;
    } on Exception catch (ex) {
      errorMessage = ex.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
