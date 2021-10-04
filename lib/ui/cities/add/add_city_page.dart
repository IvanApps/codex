import 'package:appweather/data/repository/api_repository.dart';
import 'package:appweather/data/repository/storage_city.dart';
import 'package:appweather/model/new_city.dart';
import 'package:appweather/ui/cities/add/add_city_bloc.dart';
import 'package:appweather/ui/common/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:appweather/ui/common/header_widget.dart';
import 'package:appweather/ui/ui_constants.dart';
import 'package:provider/provider.dart';

class AddCityPage extends StatefulWidget {
  @override
  _AddCityPageState createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {
  late AddCityBloc bloc;

  void handleAddTap(NewCity city) async {
    final result = await bloc.addCity(city);
    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    bloc = AddCityBloc(
      storage: context.read<StorageCity>(),
      apiService: context.read<ApiRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(HeaderPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeaderWidget(title: 'Add city'),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: TextField(
                    //onChanged: onChangedText,
                    onSubmitted: bloc.onSubmitted,
                    controller: bloc.fieldTextCon,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      filled: true,
                      hintText: 'Search city',
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                if (bloc.errorMessage != 'X')
                  Text(
                    bloc.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bloc.cities.length,
                    itemBuilder: (context, index) {
                      final city = bloc.cities[index];
                      return ListTile(
                        title: Text(
                          city.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            handleAddTap(city);
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (bloc.loading)
                  Center(
                    child: LoaderWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
