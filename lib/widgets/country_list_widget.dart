import 'package:covid19tracker/models/country.dart';
import 'package:flutter/material.dart';

class CountryListWidget extends StatelessWidget {
  final List<Country> countries;

  const CountryListWidget({this.countries});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10, right: 18, bottom: 10, left: 18),
                child: Text("Country"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, right: 18, bottom: 10, left: 18),
                child: Text("Cases"),
              ),
            ],
          ),
          Divider(),
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, i) => Column(
                children: <Widget>[
                  ListTile(
                    title: Text("${countries[i].country}"),
                    trailing: Text("${countries[i].cases}"),
                  ),
                  Divider(),
                ],
              ),
              itemCount: 5,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text("Read more"),
          )
        ],
      ),
    );
  }
}
