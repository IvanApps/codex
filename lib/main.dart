import 'package:appweather/data/repository/api_impl.dart';
import 'package:appweather/data/repository/api_repository.dart';
import 'package:appweather/data/repository/storage_city.dart';
import 'package:appweather/data/repository/storage_impl.dart';
import 'package:appweather/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepository>(
          create: (_) => ApiImpl(),
        ),
        Provider<StorageCity>(
          create: (_) => StorageImpl(),
        ),
      ],
      child: MaterialApp(
        title: 'WeatherApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: HomePage(),
      ),
    );
  }
}
