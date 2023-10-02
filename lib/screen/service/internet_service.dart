import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService{
  
  Future<bool> internet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.wifi:
        return true;
      default:
        return false;
    }
  }
}