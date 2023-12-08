import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:startup/constant/api_end_point.dart';
import 'package:startup/constant/make_toast.dart';
import 'package:startup/model/reponse/auth_response.dart';
import 'package:startup/model/reponse/simple_response.dart';
import 'package:startup/model/request/appuser_login_request.dart';
import 'package:startup/model/request/appuser_register_request.dart';
import 'package:startup/service/shared_pref_service.dart';

import '../handler/api_request_handler.dart';

class AuthProvider with ChangeNotifier {
  bool loading;
  bool isLogin;
  AuthProvider({this.loading = false, this.isLogin = false});

  Future<void> registration(
      AppUserRegisterRequest appUserRegisterRequest) async {
    try {
      loading = true;
      notifyListeners();
      Response? response = await ApiRequestHandler.post(
          url: ApiEndPoint().userRegisterUrl,
          body: appUserRegisterRequest.toJson());

      if (response != null) {
        if (response.statusCode == 200) {
          //success response data catch here
          Map<String, dynamic> successData = response.data;
          AuthResponseRest authResponseRest =
              AuthResponseRest.fromJson(successData);
          await SharedPreferencesService.setToken(
              authResponseRest.authResponse!.authorizationToken);
          MakeToast.makingSuccesseToast(SimpleResponse.fromJson(successData));
        } else {
          Map<String, dynamic> errorResult = response.data;
          //make error toast using error result
          SimpleResponse errorData = SimpleResponse.fromJson(errorResult);
          MakeToast.makingErrorToast(errorData);
        }
      }
      loading = false;
      notifyListeners();
    } catch (e) {
      log("Exception occur:$e");
    }
    notifyListeners();
  }

  Future<void> logIn(AppUserLogInRequest appUserLogInRequest) async {
    try {
      loading = true;
      notifyListeners();

      Response? response = await ApiRequestHandler.post(
          url: ApiEndPoint().userLogInUrl, body: appUserLogInRequest.toJson());

      if (response != null) {
        if (response.statusCode == 200) {
          Map<String, dynamic> successData = response.data;
          AuthResponseRest authResponseRest =
              AuthResponseRest.fromJson(successData);
          await SharedPreferencesService.setToken(
              authResponseRest.authResponse!.authorizationToken);
          MakeToast.makingSuccesseToast(SimpleResponse.fromJson(successData));
        } else {
          Map<String, dynamic> errorResult = response.data;
          SimpleResponse errorData = SimpleResponse.fromJson(errorResult);
          MakeToast.makingErrorToast(errorData);
        }
      }
    } catch (e) {
      log("Exception occur:$e");
    }
  }

  Future<void> hasToken() async {
    if (await SharedPreferencesService.getToken() != null) {
      isLogin = true;
      notifyListeners();
    }
  }
}
