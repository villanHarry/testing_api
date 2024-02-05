import 'package:testing_api/utils/constants.dart';
import 'package:testing_api/utils/network.dart';
import 'package:testing_api/view/auth/bloc/model/login_model.dart';
import 'package:testing_api/view/auth/bloc/model/signup_model.dart';

class AuthAPI {
  static Future<LoginModel?> login(
      {String email = "", String password = ""}) async {
    try {
      final response = await AppNetwork.getRequest(
          endpoint: AppEndpoints.login.name,
          bodyParameters: {"email": email, "password": password},
          contentType: ContentType.ApplicationJson);
      if (response != null) {
        final model = loginModelFromJson(response.body);
        if (model.status == 1) {
          return model;
        } else {
          Constants.showToast(model.message ?? "");
        }
      }
    } catch (e) {
      Constants.showToast(e.toString());
    }
    return null;
  }

  static Future<SignUpModel?> signUp(
      {String email = "", String password = ""}) async {
    try {
      final response = await AppNetwork.postRequest(
          endpoint: AppEndpoints.signup.name,
          bodyParameters: {"email": email, "password": password},
          contentType: ContentType.ApplicationJson);
      if (response != null) {
        final model = signUpModelFromJson(response.body);
        if (model.status == 1) {
          return model;
        } else {
          Constants.showToast(model.message ?? "");
        }
      }
    } catch (e) {
      Constants.showToast(e.toString());
    }
    return null;
  }
}
