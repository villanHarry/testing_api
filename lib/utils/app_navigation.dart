import 'package:flutter/material.dart';
import 'package:testing_api/utils/constants.dart';

class AppNavigation {
  static void push(Widget screen) =>
      Navigator.of(Constants.navigatorKey.currentContext!)
          .push(MaterialPageRoute(builder: (context) => screen));

  static void pop() => Navigator.pop(Constants.navigatorKey.currentContext!);

  static void pushReplacement(Widget screen) =>
      Navigator.of(Constants.navigatorKey.currentContext!)
          .pushReplacement(MaterialPageRoute(builder: (context) => screen));

  static void popallStack(Widget screen) {
    Navigator.of(Constants.navigatorKey.currentContext!)
        .popUntil((route) => route.isFirst);
    push(screen);
  }
}
