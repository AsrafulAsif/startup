import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:startup/model/request/appuser_register_request.dart';
import 'package:startup/provider/auth_provider.dart';
import 'package:startup/components/custome_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var userNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var passwordController = TextEditingController();

  bool showErrorText = false;

  void _registration() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    AppUserRegisterRequest registerRequest = AppUserRegisterRequest(
        userName: userNameController.text,
        phoneNumber: mobileNumberController.text,
        appPassword: passwordController.text,
        fcmToken: fcmToken.toString(),
        deviceType: Platform.operatingSystem.toUpperCase());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false)
          .registration(registerRequest);
      // var pro = Provider.of<InternetCheckProvidr>(context, listen: false);
      // pro.hasInternatFun();

      // log(pro.hasInternat.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            showErrorText = false;
          });
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Registration Here",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    CustomTextField(
                      labelText: "User Name",
                      textEditingController: userNameController,
                      showErrorText: showErrorText,
                    ),
                    CustomTextField(
                      labelText: "Mobile Number",
                      textEditingController: mobileNumberController,
                      showErrorText: showErrorText,
                    ),
                    CustomTextField(
                      labelText: "Password",
                      textEditingController: passwordController,
                      showErrorText: showErrorText,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Already Have an account?",
                          )),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Ink(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.blueGrey, width: 1),
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: InkWell(
                        splashColor: Colors.greenAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        onTap: () async {
                          if (userNameController.text.isEmpty ||
                              mobileNumberController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            setState(() {
                              showErrorText = true;
                            });
                          } else {
                            setState(() {
                              showErrorText = false;
                            });
                            _registration();
                          }
                        },
                        child: const SizedBox(
                          height: 50.0,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
