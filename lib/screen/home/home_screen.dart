import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/api_end_point.dart';
import '../../constant/make_toast.dart';
import '../../handler/api_request_handler.dart';
import '../../model/reponse/simple_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  String? imageUrl;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      log(image.path.toString());
      Map<String, dynamic> params = {
        "appUserId": DateTime.now(),
      };
      Response? response = await ApiRequestHandler.postFile(
          url: ApiEndPoint().fileUploadUrl, file: this.image, params: params);

      if (response != null) {
        if (response.statusCode == 200) {
          //success response data catch here
          Map<String, dynamic> successData = response.data;
          setState(() {
            imageUrl = successData["imageUrlResponse"]["imageUrl"];
          });
          log(successData["imageUrlResponse"]["imageUrl"].toString());
          MakeToast.makingSuccesseToast(SimpleResponse.fromJson(successData));
        } else {
          Map<String, dynamic> errorResult = response.data;
          //make error toast using error result
          SimpleResponse errorData = SimpleResponse.fromJson(errorResult);
          MakeToast.makingErrorToast(errorData);
        }
      }
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            // Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
            // const SizedBox(height: 24),
            // Text(picture.name)

            MaterialButton(
                color: Colors.blue,
                child: const Text("Pick Image from Gallery",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  pickImage();
                }),

            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                      )
                    : const Text("No Image"),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
