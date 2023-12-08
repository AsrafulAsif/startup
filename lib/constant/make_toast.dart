
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup/model/reponse/simple_response.dart';

class MakeToast{
  
  static void makingErrorToast(SimpleResponse errorData){
    Fluttertoast.showToast(
              backgroundColor: Colors.red,
              msg:
                  '${errorData.message} with status code ${errorData.statusCode}');

  }

  static void makingSuccesseToast(SimpleResponse successData){
    Fluttertoast.showToast(
              backgroundColor: Colors.green,
              msg:
                  '${successData.message} with status code ${successData.statusCode}');

  }

}