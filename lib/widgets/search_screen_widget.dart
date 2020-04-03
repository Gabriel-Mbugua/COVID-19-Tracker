import 'package:flutter/material.dart';

import 'package:covid19tracker/models/country.dart';

class SearchScreenWidget extends StatefulWidget {
  final List<Country> countries;

  SearchScreenWidget({this.countries});

  @override
  _SearchScreenWidgetState createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  List<Country> filteredCountries;

  Future<void> _getAllCountries() async {
    setState(() {
      filteredCountries = widget.countries;
    });
//    return widget.countries
//        .where((country) =>
//            country.country.toLowerCase().contains(query.toLowerCase()))
//        .toList();
  }

  @override
  void didChangeDependencies() {
    _getAllCountries();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: filteredCountries == null
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2,
            ))
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Enter country",
                    ),
                    onChanged: (string) {
                      setState(() {
                        filteredCountries = widget.countries
                            .where((country) => (country.country
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (ctx, i) {
                        return Card(
                          color: Theme.of(context).primaryColorLight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      filteredCountries[i].country,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Cases: ${filteredCountries[i].cases.toString()}",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        "Deaths: ${filteredCountries[i].deaths.toString()}"),
                                    Text(
                                        "Recovered: ${filteredCountries[i].recovered.toString()}"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
