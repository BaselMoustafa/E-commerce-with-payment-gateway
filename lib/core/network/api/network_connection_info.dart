
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnectionInfo{
  Future<bool> get isConnected; 
}

class NetworkConnectionInfoImple extends NetworkConnectionInfo{
 final InternetConnectionChecker internetConnectionChecker;
    NetworkConnectionInfoImple({required this.internetConnectionChecker});
  Future<bool> get isConnected  {
    return internetConnectionChecker.hasConnection;
  }

}