import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testing_api/utils/app_navigation.dart';
import 'package:testing_api/utils/constants.dart';
import 'package:testing_api/utils/shared_preferences.dart';
import 'package:testing_api/view/auth/login.dart';
import 'package:testing_api/view/home_screen/bloc/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool power = false;
  int value = 0;
  late final userProvider = context.read<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.darkMode,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 1.sw,
                    height: .86.sh,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25))),
                  ),
                ),
                Positioned(
                  top: -100,
                  right: -.9.sw,
                  child: Icon(
                    Icons.ac_unit_rounded,
                    size: 600.r,
                    color: Colors.white12,
                  ),
                ),
                Positioned(
                  bottom: -.3.sh,
                  left: -.6.sw,
                  child: Icon(
                    Icons.ac_unit_rounded,
                    size: 400.r,
                    color: Colors.white12,
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 1.sw,
                    height: 1.sh,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Center(
                        child: Column(children: [
                          45.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.ac_unit_rounded,
                                size: 25.r,
                                color: Colors.blue,
                              ),
                              10.horizontalSpace,
                              Text(
                                  "Hi ${(userProvider.user!.email ?? "").split("@").first}",
                                  style: TextStyle(
                                      height: 0,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp)),
                              10.horizontalSpace,
                              GestureDetector(
                                onTap: () async {
                                  userProvider.clear();
                                  final value = await PreferenceUtils.init();
                                  await value.clear();
                                  AppNavigation.popallStack(
                                      const LoginScreen());
                                },
                                child: Icon(
                                  Icons.power_settings_new_rounded,
                                  size: 25.r,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          70.verticalSpace,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              50.horizontalSpace,
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                width: value > 0 ? .4.sw : .5.sw,
                                height: .2.sh,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: Colors.blue.shade800),
                                child: Text("$value",
                                    style: TextStyle(
                                        height: 0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 100.sp)),
                              ),
                              10.horizontalSpace,
                              Text("°",
                                  style: TextStyle(
                                      height: 0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 60.sp)),
                              Text("C",
                                  style: TextStyle(
                                      height: 0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 30.sp)),
                              const Spacer(),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (power && value <= 24) {
                                    setState(() {
                                      value++;
                                    });
                                  }
                                },
                                child: Opacity(
                                  opacity: power ? 1 : 0.5,
                                  child: Container(
                                    padding: EdgeInsets.all(5.r),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.arrow_drop_up_rounded,
                                      size: 50.r,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    power = !power;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15.r),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.ac_unit_rounded,
                                    size: 60.r,
                                    color: power ? Colors.blue : Colors.red,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (power && value >= -24) {
                                    setState(() {
                                      value--;
                                    });
                                  }
                                },
                                child: Opacity(
                                  opacity: power ? 1 : 0.5,
                                  child: Container(
                                    padding: EdgeInsets.all(5.r),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      size: 50.r,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          50.verticalSpace,
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
