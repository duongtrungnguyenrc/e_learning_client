import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkUtils {
  static bool checkInternetConnection() {
    InternetConnectionChecker().hasConnection.then(
      (bool conntection) {
        return conntection;
      },
    );
    return false;
  }
}
