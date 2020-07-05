import 'package:covid19tracker/models/country.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreenWidget extends StatefulWidget {
  final List<Country> countries;

  SearchScreenWidget({this.countries});

  @override
  _SearchScreenWidgetState createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  List<Country> filteredCountries;
  final numberFormatter = NumberFormat("#,###");

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
                            child: ExpandablePanel(
                              hasIcon: false,
                              expanded: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              "Today's Cases: ${numberFormatter.format(filteredCountries[i].todayCases).toString()}"),
                                          Text(
                                              "Critical: ${numberFormatter.format(filteredCountries[i].critical).toString()}"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(filteredCountries[i]
                                                      .todayDeaths ==
                                                  null
                                              ? "Today's Deaths: NA"
                                              : "Today's Deaths: ${numberFormatter.format(filteredCountries[i].todayDeaths).toString()}"),
                                          Text(filteredCountries[i].active ==
                                                  null
                                              ? "Active: NA"
                                              : "Active: ${numberFormatter.format(filteredCountries[i].active).toString()}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              header: Column(
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
                                        "Cases: ${numberFormatter.format(filteredCountries[i].cases).toString()}",
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
                                      Text(widget.countries[i].deaths == null
                                          ? "Deaths: N/A"
                                          : "Deaths: ${numberFormatter.format(filteredCountries[i].deaths).toString()}" ),
                                      Text(widget.countries[i].recovered == null
                                          ?  "Recovered: N/A"
                                          :"Recovered: ${numberFormatter.format(filteredCountries[i].recovered).toString()}"),
                                    ],
                                  ),
                                ],
                              ),
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
