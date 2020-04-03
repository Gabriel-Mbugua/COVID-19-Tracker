import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:covid19tracker/app/services/api_service.dart';
import 'package:covid19tracker/enums/connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:covid19tracker/models/country.dart';
import 'package:covid19tracker/widgets/home_screen_widget.dart';
import 'package:covid19tracker/widgets/search_screen_widget.dart';
import 'package:covid19tracker/widgets/alert_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isInit = true;
  var _isLoading = false;
  int _cIndex = 0;
  int _cases;
  int _deaths;
  int _recovered;
  List<Country> _countries;
  String lastUpdated = DateFormat('hh:mm a').format(DateTime.now());

  @override
  void didChangeDependencies() {
    print("Debug: didChangeDependencies()");
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _checkConnectivity();
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  Future<void> _checkConnectivity() async {
    try {
      final check = await InternetAddress.lookup("google.com");
      if (check.isNotEmpty && check[0].rawAddress.isNotEmpty) {
        _fetchData().then((_) => _fetchCountries());
      }
    } catch (ex) {
      setState(() {
        _isLoading = false;
      });
      return showDialog(
        context: context,
        builder: (_) => AlertWidget(),
        barrierDismissible: false,
      );
    }
  }

  Future<void> _fetchData() async {
    final apiService = APIService();
    final summaryData = await apiService.getSummaryData();
    setState(() {
      _cases = summaryData.cases;
      _deaths = summaryData.deaths;
      _recovered = summaryData.recovered;
      _isLoading = false;
    });
    print(_cases);
  }

  Future<List<Country>> _fetchCountries() async {
    final apiService = APIService();
    final countries = await apiService.getCountries();
    setState(() {
      _countries = countries;
    });
    print(countries.sublist(0, 4));
    return _countries;
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("COVID-19"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:
      _isLoading
          ? Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            )
          : _cIndex == 0
              ? RefreshIndicator(
                  onRefresh: () async{
                    await _fetchData();
                    await _fetchCountries();
                    lastUpdated = DateFormat('hh:mm a').format(DateTime.now());
                  },
                  child: HomeScreenWidget(
                    cases: _cases,
                    recovered: _recovered,
                    deaths: _deaths,
                    countries: _countries,
                    lastUpdated: lastUpdated,
                  ),
                )
              : SearchScreenWidget(
                  countries: _countries,
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),
    );
  }
}
