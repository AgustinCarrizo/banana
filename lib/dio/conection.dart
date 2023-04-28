import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Conection {
  Future<bool> conectio() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    late bool value;
    switch (connectivityResult) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        value = await checkConection() ? true : false;
        break;
      case ConnectivityResult.none:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
        value = false;
        break;
    }
    return value;
  }

  Future<bool> checkConection() async {
    final InternetConnectionStatus onStatusChange =
        await InternetConnectionChecker().connectionStatus;
    late bool value;
    switch (onStatusChange) {
      case InternetConnectionStatus.connected:
        value = true;
        break;
      case InternetConnectionStatus.disconnected:
        value = false;
        break;
    }
    return value;
  }
}
