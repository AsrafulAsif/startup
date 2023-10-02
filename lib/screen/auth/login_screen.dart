import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/custome_textfield.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var mobileNumberController = TextEditingController();
  var passwordController = TextEditingController();

  bool showErrorText = false;
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
                      "LogIn Here",
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
                            "Don't Have an account?",
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
                          if (mobileNumberController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            setState(() {
                              showErrorText = true;
                            });
                          } else {
                            setState(() {
                              showErrorText = false;
                            });
                            // _registration();
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
