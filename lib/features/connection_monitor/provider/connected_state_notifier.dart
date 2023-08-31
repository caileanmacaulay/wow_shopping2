import 'dart:async';
import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wow_shopping/widgets/common.dart';

enum MyNetworkStatus {
  OnNetwork,
  OffNetork,
  NotSureAboutNetwork,
}

//final connectivityProvider = Provider((ref) => Connectivity());

class ConnectedStateNotifier extends StateNotifier<MyNetworkStatus> {
  ConnectedStateNotifier() : super(MyNetworkStatus.NotSureAboutNetwork);

  final Connectivity connection = Connectivity();
  late StreamSubscription<ConnectivityResult> _streamOfConnectivityResults;

  void initState() {
    //listen to the stream of ConnectivityResults
    _streamOfConnectivityResults =
        connection.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.none:
          state = MyNetworkStatus.OffNetork;
          break;
        default:
          state = MyNetworkStatus.OnNetwork;
          break;
      }
    });
  }

  //dispose of listened to subscription
  @override
  void dispose() {
    _streamOfConnectivityResults.cancel();
    super.dispose();
  }
}

//make this available across App via ref
final connectedStateNotifierProvider =
    StateNotifierProvider((ref) => ConnectedStateNotifier());
