import 'dart:io';

class NetworkHelper {
  NetworkHelper._();

  static final NetworkHelper instance = NetworkHelper._();

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 1));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
