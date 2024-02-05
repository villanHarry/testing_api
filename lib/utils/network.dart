import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:testing_api/utils/constants.dart';

class AppNetwork {
  static String baseUrl = "http://192.168.1.104:3000/user/api/";

  static Future<Response?> postRequest(
      {required String endpoint,
      String? token,
      Map<String, String>? bodyParameters,
      String? secondBaseUrl,
      ContentType? contentType,
      Function()? onError}) async {
    try {
      //headers
      Map<String, String> headers = {};
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (contentType != null) {
        headers.addAll({'Content-Type': contents[contentType.name].toString()});
      }

      //request selection
      var request = _requestType(
          requestType: (contentType != ContentType.xFormUrlEncoded &&
                      contentType != ContentType.ApplicationJson) &&
                  bodyParameters != null
              ? RequestType.multiRequest
              : RequestType.request,
          method: 'POST',
          uri: '${secondBaseUrl ?? baseUrl}$endpoint');

      //parameters
      if (bodyParameters != null) {
        if (contentType == ContentType.xFormUrlEncoded) {
          request.bodyFields = bodyParameters;
        } else if (contentType == ContentType.ApplicationJson) {
          request.body = json.encode(bodyParameters);
        } else {
          request.fields.addAll(bodyParameters);
        }
      }
      request.headers.addAll(headers);

      //internet connectivity
      final internet = await Connectivity().checkConnectivity();
      if (internet == ConnectivityResult.none) {
        Constants.showToast("Not Connected to Internet");
        return null;
      }

      StreamedResponse response = await request.send();
      final Response res = await Response.fromStream(response);

      if (response.statusCode == 200) {
        return res;
      } else {
        if (onError != null) {
          onError();
        }
        return null;
      }
    } on Exception catch (e) {
      Constants.showToast(e.toString());
      return null;
    }
  }

  static Future<Response?> getRequest(
      {required String endpoint,
      String? token,
      Map<String, String>? bodyParameters,
      String? secondBaseUrl,
      ContentType? contentType,
      Function()? onError}) async {
    try {
      //headers
      Map<String, String> headers = {};
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (contentType != null) {
        headers.addAll({'Content-Type': contents[contentType.name].toString()});
      }

      //request selection
      var request = _requestType(
          requestType: (contentType != ContentType.xFormUrlEncoded &&
                      contentType != ContentType.ApplicationJson) &&
                  bodyParameters != null
              ? RequestType.multiRequest
              : RequestType.request,
          method: 'GET',
          uri: '${secondBaseUrl ?? baseUrl}$endpoint');

      //parameters
      if (bodyParameters != null) {
        if (contentType == ContentType.xFormUrlEncoded) {
          request.body = bodyParameters;
        } else if (contentType == ContentType.ApplicationJson) {
          request.body = json.encode(bodyParameters);
        } else {
          request.fields.addAll(bodyParameters);
        }
      }
      request.headers.addAll(headers);

      //internet connectivity
      final internet = await Connectivity().checkConnectivity();
      if (internet == ConnectivityResult.none) {
        Constants.showToast("Not Connected to Internet");
        return null;
      }

      StreamedResponse response = await request.send();
      final Response res = await Response.fromStream(response);

      if (response.statusCode == 200) {
        return res;
      } else {
        if (onError != null) {
          onError();
        }
        return null;
      }
    } on Exception catch (e) {
      Constants.showToast(e.toString());
      return null;
    }
  }

  static final contents = {
    ContentType.xFormUrlEncoded.name: "application/x-www-form-urlencoded",
    ContentType.ApplicationJson.name: "application/json"
  };

  static dynamic _requestType(
      {required RequestType requestType,
      required String method,
      required String uri}) {
    switch (requestType) {
      case RequestType.request:
        return Request(method, Uri.parse(uri));

      case RequestType.multiRequest:
        return MultipartRequest(method, Uri.parse(uri));
    }
  }
}

enum AppEndpoints { login, signup, profile }

enum ContentType { xFormUrlEncoded, ApplicationJson }

enum RequestType { request, multiRequest }
