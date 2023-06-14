import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall_m/models/connect_model.dart';

class ConnectProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();
  ConnectModel connectModel = ConnectModel(connectStatus: "waiting");

  void chechInternet() {
    connectModel.connectStream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          connectModel.connectStatus = "Wifi";
          notifyListeners();
          break;
        case ConnectivityResult.mobile:
          connectModel.connectStatus = "mobile";
          notifyListeners();
          break;
        default:
          connectModel.connectStatus = "waiting";
      }
    });
  }
}
