library internet_popup;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'custom_dialog.dart';

class InternetPopup {
  bool _isOnline = false;
  bool _isDialogOn = false;

  final Connectivity _connectivity = Connectivity();

  static final InternetPopup _internetPopup = InternetPopup._internal();

  factory InternetPopup() {
    return _internetPopup;
  }

  InternetPopup._internal();

  void initialize(
      {required BuildContext context,
      String? customMessage,
      String? customDescription,
      bool? onTapPop = false,
      Function? onChange}) {
    final navigator = Navigator.of(context);
    _connectivity.checkConnectivity().then((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await InternetConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }
      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;
        // ignore: use_build_context_synchronously
        Alerts(context: context).customDialog(
            type: AlertType.signal,
            message: customMessage ?? 'No Internet Connection Found !',
            description: customDescription ?? 'Please check your internet connection on your smartphone to use the application .',
            showButton: onTapPop,
            onTap: () {
              _isDialogOn = false;
              navigator.pop();
            });
      }
    });

    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await InternetConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;
        // ignore: use_build_context_synchronously
        Alerts(context: context).customDialog(
            type: AlertType.signal,
            message: customMessage ?? 'No Internet Connection Found !',
            description: customDescription ?? 'Please check your internet connection on your smartphone to use the application .',
            showButton: onTapPop,
            onTap: () {
              _isDialogOn = false;
              navigator.pop();
            });
      }
      if (onChange != null) {
        onChange(_isOnline);
      }
    });
  }

  void initializeCustomWidget(
      {required BuildContext context, required Widget widget}) {
    final navigator = Navigator.of(context);

    _connectivity.checkConnectivity().then((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await InternetConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;

        // ignore: use_build_context_synchronously
        Alerts(context: context).showModalWithWidget(child: widget);
      }
    });

    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        _isOnline = await InternetConnectionChecker().hasConnection;
      } else {
        _isOnline = false;
      }

      if (_isOnline == true) {
        if (_isDialogOn == true) {
          _isDialogOn = false;
          navigator.pop();
        }
      } else {
        _isDialogOn = true;

        // ignore: use_build_context_synchronously
        Alerts(context: context).showModalWithWidget(child: widget);
      }
    });
  }

  Future<bool> checkInternet() async {
    bool isConnected = false;
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      isConnected = await InternetConnectionChecker().hasConnection;
    }
    return isConnected;
  }

  Future<String> getConnectionType() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return "mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return "wifi";
    } else {
      return "mobile";
    }
  }
}
