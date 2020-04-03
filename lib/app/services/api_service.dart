import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:covid19tracker/models/summary_data.dart';
import 'package:covid19tracker/models/country.dart';
import 'package:covid19tracker/app/services/api.dart';

class APIService {
  final API api;

  APIService({this.api});

  Future<bool> checkConnection() async {
    try {
      final check = await InternetAddress.lookup("google.com");
      if (check.isNotEmpty && check[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (ex) {
      return false;
    }
    return false;
  }

  Future<void> _checkConnectivity() async {
    final check = await InternetAddress.lookup("google.com");
    if (check.isNotEmpty && check[0].rawAddress.isNotEmpty) {
      getSummaryData().then((_) => getCountries());
    }
  }

  Future<SummaryData> getSummaryData() async {
    final response =
    await http.get("https://coronavirus-19-api.herokuapp.com/all");

    if (response.statusCode == 200) {
      var data = SummaryData.fromJson(json.decode(response.body));
      print(data);
      return data;
    }
    throw response;
  }

  Future<List<Country>> getCountries() async {
    final response =
    await http.get("https://coronavirus-19-api.herokuapp.com/countries");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final parsed = data.cast<Map<String, dynamic>>();
      return parsed.map<Country>((json) => Country.fromJson(json)).toList();
    }
    throw response;
  }
}

