import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:startup/constant/api_end_point.dart';
import 'package:startup/constant/make_toast.dart';
import 'package:startup/model/reponse/auth_response.dart';
import 'package:startup/model/reponse/simple_response.dart';
import 'package:startup/model/request/appuser_register_request.dart';
import 'package:startup/screen/service/shared_pref_service.dart';

import '../screen/service/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool setToken = false;

  Future<void> registration(
      AppUserRegisterRequest appUserRegisterRequest) async {
    try {
      Response? response = await ApiService.post(
          url: ApiEndPoint().userRegisterUrl,
          body: appUserRegisterRequest.toJson());

      if (response != null) {
        if (response.statusCode == 200) {
          //success response data catch here
          Map<String, dynamic> successData = response.data;
          AuthResponseRest authResponseRest = AuthResponseRest.fromJson(successData);
          authResponseRest.authResponse!.authorizationToken;
          setToken = await SharedPreferencesService.setToken(
              authResponseRest.authResponse!.authorizationToken);
          MakeToast.makingSuccesseToast(SimpleResponse.fromJson(successData));
        } else {
          Map<String, dynamic> errorResult = response.data;
          //make error toast using error result
          SimpleResponse errorData = SimpleResponse.fromJson(errorResult);
          MakeToast.makingErrorToast(errorData);
        }
      }
    } catch (e) {
      log("Exception occur:$e");
    }
    notifyListeners();
  }
}
