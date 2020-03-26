import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:covid19tracker/app/services/api.dart';
import 'package:covid19tracker/app/services/api_service.dart';
import 'package:covid19tracker/widgets/card_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        accentColor: Colors.green,
        iconTheme: IconThemeData(size: 50),
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = "";
  int _cases;
  int _suspected;
  int _confirmed;
  int _deaths;
  int _recovered;

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    print("Debug: DID CHANGE DEPENDENCIES WAS CALLED!");

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _fetchData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _fetchData() async {
    final apiService = APIService(api: API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.cases,
    );
    final confirmed = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.casesConfirmed,
    );
    final deaths = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.deaths,
    );
    final recovered = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.recovered,
    );
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _confirmed = confirmed;
      _deaths = deaths;
      _recovered = recovered;
      _isLoading = false;
    });
    print("Debug _updateAccessToken: $accessToken ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text("Covid-19"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _fetchData();
                    },
                    child: ListView.builder(
                      itemBuilder: (_, i) => Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                                "Last Updated: ${DateFormat('hh:mm a').format(DateTime.now())}"),
                          ),
                          CardWidget(
                            data: _cases,
                            title: "Cases",
                            icon: FontAwesomeIcons.clipboardList,
                            color: Colors.amberAccent,
                          ),
                          CardWidget(
                            data: _confirmed,
                            title: "Confrimed",
                            icon: FontAwesomeIcons.diagnoses,
                            color: Colors.deepOrange,
                          ),
                          CardWidget(
                            data: _deaths,
                            title: "Deaths",
                            icon: FontAwesomeIcons.skull,
                            color: Colors.red,
                          ),
                          CardWidget(
                            data: _recovered,
                            title: "Recovered",
                            icon: FontAwesomeIcons.medkit,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      itemCount: 1,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
