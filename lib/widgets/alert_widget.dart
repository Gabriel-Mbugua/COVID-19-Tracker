import 'package:flutter/material.dart';

import 'package:covid19tracker/app/services/api_service.dart';


class AlertWidget extends StatelessWidget {
  Future<void> checkConnection() async {
    final apiService = APIService();
    final connection = await apiService.checkConnection();

  }

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text("No Internet Connection"),
      content: Text("You need to have a mobile data or wifi access. Press ok to exit"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
            },
        ),
      ],
      backgroundColor: Theme.of(context).primaryColorLight,
    );
  }
}
