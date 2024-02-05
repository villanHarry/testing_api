import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static String token = "token";
  static var lightMode = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light);

  static var darkMode = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Color backgroundColor = const Color(0xFF2646B7);

  static Future<void> showToast(String value) async {
    await Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0);
  }
}
