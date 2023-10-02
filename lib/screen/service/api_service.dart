import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:startup/screen/service/internet_service.dart';

class ApiService{
  static Map<String, String> defaultHeaders = {'Content-Type': "application/json"};

  static Future<dynamic> post({
    required String url,
    var body,
    Map<String, String>? headers,
  }) async {
    bool internet = await InternetService().internet(); // check internet connection
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
    } catch (e) {
      return e;
    }
  }
}