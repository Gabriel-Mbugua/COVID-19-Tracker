import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid19tracker/enums/connectivity_status.dart';

class ConnectivityService{
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();

  ConnectivityService(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //Convert result into our enum
      var connectionStatus =_getStatusFromResult(result);
      //Emit this over a stream
      connectionStatusController.add(connectionStatus);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.mobile:
        return  ConnectivityStatus.Online;
      case ConnectivityResult.wifi:
        return  ConnectivityStatus.Online;
      case ConnectivityResult.none:
        return  ConnectivityStatus.Offline;
      default:
        return  ConnectivityStatus.Offline;
    }
  }
}