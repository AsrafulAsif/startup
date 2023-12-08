import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:startup/service/internet_service.dart';

class ApiRequestHandler {
  static Map<String, String> defaultHeaders = {
    'Content-Type': "application/json"
  };

  //for post
  static Future<dynamic> post({
    required String url,
    var body,
    Map<String, String>? headers,
  }) async {
    bool internet =
        await InternetService().internet(); // check internet connection
    if (internet == false) return null;

    CancelToken cancelToken = CancelToken();

    headers != null
        ? headers = {...defaultHeaders, ...headers}
        : headers = {...defaultHeaders};

    try {
      Dio dio = Dio();

      Response response = await dio.post(
        url,
        data: jsonEncode(body),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          headers: headers,
        ),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      return log(e.toString());
    }
  }

  //for get
  static Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    bool internet =
        await InternetService().internet(); // check internet connection
    if (internet == false) return null;

    CancelToken cancelToken = CancelToken();

    headers != null
        ? headers = {...defaultHeaders, ...headers}
        : headers = {...defaultHeaders};

    try {
      Dio dio = Dio();

      Response response = await dio.get(
        url,
        queryParameters: params,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          headers: headers,
        ),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      return log(e.toString());
    }
  }

  //for update
  static Future<dynamic> update({
    required String url,
    var body,
    Map<String, String>? headers,
  }) async {
    bool internet =
        await InternetService().internet(); // check internet connection
    if (internet == false) return null;

    CancelToken cancelToken = CancelToken();

    headers != null
        ? headers = {...defaultHeaders, ...headers}
        : headers = {...defaultHeaders};

    try {
      Dio dio = Dio();
      Response response = await dio.put(
        url,
        data: jsonEncode(body),
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          headers: headers,
        ),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      return log(e.toString());
    }
  }

  static Future<dynamic> postFile({
    required String url,
     File? file,
    Map<String, dynamic>? params,
  }) async {
    bool internet =
        await InternetService().internet(); // check internet connection
    if (internet == false) return null;

    CancelToken cancelToken = CancelToken();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    headers = {...defaultHeaders, ...headers};
    String fileName = file!.path.split('/').last;
     FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path,filename: fileName)
    });

    try {
      Dio dio = Dio();

      Response response = await dio.post(
        url,
        queryParameters: params,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          headers: headers,
        ),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      return log(e.toString());
    }
  }
}
