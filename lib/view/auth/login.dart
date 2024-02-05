import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testing_api/utils/app_navigation.dart';
import 'package:testing_api/utils/constants.dart';
import 'package:testing_api/utils/shared_preferences.dart';
import 'package:testing_api/view/auth/bloc/auth.dart';
import 'package:testing_api/view/auth/signup.dart';
import 'package:testing_api/view/home_screen/bloc/home_provider.dart';
import 'package:testing_api/view/home_screen/bloc/model/user.dart';
import 'package:testing_api/view/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.lightMode,
        child: Scaffold(
            backgroundColor: Colors.blue,
            body: PopScope(
              canPop: false,
              child: Stack(
                children: [
                  Positioned(
                    top: -.3.sh,
                    right: -.8.sw,
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
                            70.verticalSpace,
                            Row(
                              children: [
                                const Spacer(),
                                Text("Login",
                                    style: TextStyle(
                                        height: 0,
                                        color: Colors.white,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.sp)),
                                const Spacer(),
                              ],
                            ),
                            const Spacer(),
                            TextFormField(
                              controller: email,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 30.w),
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.5.sp,
                                      fontWeight: FontWeight.w500),
                                  prefixIconConstraints: BoxConstraints(
                                      maxHeight: 30.r, maxWidth: 55.w),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: const Icon(Icons.email,
                                        color: Colors.blue),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                            10.verticalSpace,
                            TextFormField(
                              controller: pass,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 30.w),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.5.sp,
                                      fontWeight: FontWeight.w500),
                                  prefixIconConstraints: BoxConstraints(
                                      maxHeight: 30.r, maxWidth: 55.w),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: const Icon(Icons.lock,
                                        color: Colors.blue),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                            20.verticalSpace,
                            GestureDetector(
                              onTap: () async {
                                if (email.text.isNotEmpty &&
                                    pass.text.isNotEmpty) {
                                  setState(() {
                                    loading = true;
                                  });
                                  final model = await AuthAPI.login(
                                      email: email.text, password: pass.text);

                                  if (model != null) {
                                    final value = await PreferenceUtils.init();
                                    await value.setString(Constants.token,
                                        model.data!.accessToken ?? "");
                                    final tempUser = User(
                                        email: model.data!.user!.email,
                                        id: model.data!.user!.id,
                                        accessToken:
                                            model.data!.accessToken ?? "");
                                    context
                                        .read<UserProvider>()
                                        .setUser(tempUser);
                                    AppNavigation.popallStack(
                                        const HomeScreen());
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Login",
                                        style: TextStyle(
                                            height: 1,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp)),
                                  ],
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        height: 1,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp),
                                    text: "Need an account? ",
                                    children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          AppNavigation.push(
                                              const SignUpScreen());
                                        },
                                      text: "Create Account",
                                      style: TextStyle(
                                          height: 1,
                                          decoration: TextDecoration.underline,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.sp))
                                ])),
                            const Spacer(),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: loading,
                    child: Container(
                      height: 1.sh,
                      width: 1.sw,
                      color: Colors.black38,
                      child: const Center(
                          child:
                              CircularProgressIndicator(color: Colors.white)),
                    ),
                  )
                ],
              ),
            )));
  }
}
