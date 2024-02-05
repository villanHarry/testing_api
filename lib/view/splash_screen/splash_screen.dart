import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testing_api/utils/app_navigation.dart';
import 'package:testing_api/utils/constants.dart';
import 'package:testing_api/utils/shared_preferences.dart';
import 'package:testing_api/view/auth/login.dart';
import 'package:testing_api/view/home_screen/bloc/home_provider.dart';
import 'package:testing_api/view/home_screen/bloc/model/user.dart';
import 'package:testing_api/view/home_screen/home_screen.dart';
import 'package:testing_api/view/splash_screen/bloc/profile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int value = 0;
  late Timer timer;

  Future<void> data() async {
    final value = await PreferenceUtils.init();
    final token = await value.getString(Constants.token);
    if (token != null) {
      final model = await ProfileApi.getProfile(token: token ?? "");
      if (model != null) {
        Constants.navigatorKey.currentContext!.read<UserProvider>().setUser(
            User(
                email: model.data!.user!.email,
                id: model.data!.user!.email,
                accessToken: token));
        loggedinNavigation();
      } else {
        loggedinNavigation();
      }
    } else {
      normalNavigation();
    }
  }

  void loggedinNavigation() {
    AppNavigation.pushReplacement(const HomeScreen());
  }

  void normalNavigation() {
    AppNavigation.pushReplacement(const LoginScreen());
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        value++;
      });
    });
    Timer(const Duration(milliseconds: 3000), () async {
      await data();
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Constants.lightMode,
      child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                25.verticalSpace,
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    35.horizontalSpace,
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: Icon(
                        Icons.ac_unit_rounded,
                        size: 60.r,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 60.r,
                      child: Row(
                        children: [
                          Text(
                            "°",
                            style: TextStyle(
                                height: 0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 50.sp),
                          ),
                          1.horizontalSpace,
                          Column(
                            children: [
                              Text(
                                "-$value",
                                style: TextStyle(
                                    height: 0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.sp),
                              ),
                              const Spacer()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  "Air Condition",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp),
                ),
                25.verticalSpace
              ],
            ),
          )),
    );
  }
}
