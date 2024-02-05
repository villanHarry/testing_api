import 'package:testing_api/utils/constants.dart';
import 'package:testing_api/utils/network.dart';
import 'package:testing_api/view/splash_screen/bloc/model/profile_model.dart';

class ProfileApi {
  static Future<ProfileModel?> getProfile({String token = ""}) async {
    try {
      final response = await AppNetwork.getRequest(
          endpoint: AppEndpoints.profile.name,
          token: token,
          contentType: ContentType.ApplicationJson);
      if (response != null) {
        final model = profileModelFromJson(response.body);
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
