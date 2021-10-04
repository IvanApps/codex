import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appweather/data/repository/api_repository.dart';
import 'package:appweather/data/repository/storage_city.dart';
import 'package:appweather/ui/common/loader_widget.dart';
import 'package:appweather/ui/home/empty_widget.dart';
import 'package:appweather/ui/home/weathers_widget.dart';
import 'package:appweather/ui/home_bloc.dart';
import 'package:appweather/ui/cities/cities_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late HomeBloc bloc;

  void didChangeAppLifecicleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      bloc.loadCities();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    bloc = HomeBloc(
      apiService: context.read<ApiRepository>(),
      storage: context.read<StorageCity>(),
    );
    bloc.loadCities();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void handleNavigationPress(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CitiesPage()),
    );
    bloc.loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
          body: bloc.cities.isEmpty
              ? bloc.loading
                  ? Center(child: LoaderWidget())
                  : EmptyWidget(
                      onTap: () => handleNavigationPress(context),
                    )
              : WeathersWidget(
                  cities: bloc.cities,
                  onTap: () => handleNavigationPress(context),
                ),
        );
      },
    );
  }
}
