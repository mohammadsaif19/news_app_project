import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  final Connectivity _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  InternetService() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}
