import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:covid19tracker/widgets/tile_widget.dart';
import 'package:covid19tracker/models/country.dart';

class HomeScreenWidget extends StatefulWidget {
  final int cases;
  final int deaths;
  final int recovered;
  final List<Country> countries;
  final String lastUpdated;

  HomeScreenWidget(
      {this.cases,
      this.deaths,
      this.recovered,
      this.countries,
      this.lastUpdated});

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Last updated at: ${widget.lastUpdated}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Flexible(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        TileWidget(
                          data: widget.cases,
                          title: "Cases",
                          icon: FontAwesomeIcons.clipboardList,
                          color: Colors.amberAccent,
                        ),
                        TileWidget(
                          data: widget.deaths,
                          title: "Deaths",
                          icon: FontAwesomeIcons.biohazard,
                          color: Colors.red,
                        ),
                        TileWidget(
                          data: widget.recovered,
                          title: "Recovered",
                          icon: FontAwesomeIcons.medkit,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  widget.countries != null
                      ? Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(
                                            child: Text("Country",
                                                style: TextStyle(
                                                    color: Colors.blueGrey)),
                                          ),
                                        ),
                                        TableCell(
                                            child: Center(
                                          child: Text(
                                            "Cases",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                        )),
                                        TableCell(
                                            child: Center(
                                          child: Text(
                                            "Deaths",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          ),
                                        )),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              "Recovered",
                                              style: TextStyle(
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (ctx, i) {
                                    return Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                  child: Text(
                                                widget.countries[i].country,
                                              )),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                  child: Text(
                                                      widget.countries[i].cases
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.yellow))),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                  child: Text(
                                                      widget.countries[i].deaths
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.red))),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                  child: Text(
                                                widget.countries[i].recovered
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )),
                                            )),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
