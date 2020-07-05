import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:covid19tracker/app/services/api_service.dart';
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

  Country _userCountryInfo;
  Country _position;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _checkPermissions();
      _checkConnectivity();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _checkPermissions() async{
    var status = await Permission.location.status;
    print("************status: $status");
    if(status == PermissionStatus.undetermined){
      await Permission.location.request();
    }
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
  }

  Future<List<Country>> _fetchCountries() async {
    final apiService = APIService();
    final countries = await apiService.getCountries();

    setState(() {
      _countries = countries;
    });
//    _userLocation();
    getUserCountry();
    return _countries;
  }


  Future<Country> getUserCountry() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    final userCountry = _countries.firstWhere((country) => country.country == placemark[0].country);
    setState(() {
      _userCountryInfo = userCountry;
    });
    return _userCountryInfo;
  }


  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if(brightness == Brightness.dark){
      print("Dark mode");
    }
    else{
      print("Normal mode");
    }

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
                    userCountry: _userCountryInfo,
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
