import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_project/controllers/utilities_controller.dart';

import 'package:flutter_project/screens/forgotpassword_screen.dart';

class LoginScreen extends GetWidget<UtilitiesController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailInputCtrl = TextEditingController();
  final TextEditingController _passwordInputCtrl = TextEditingController();

  final AuthController _authCtrl = Get.find();

  handleFormSubmit() async {
    await _authCtrl.login(_emailInputCtrl.text, _passwordInputCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UtilitiesController>(builder: (controller) {
      return Scaffold(
        key: _scaffoldKey,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0xFF7519EB), Color(0xFFDEC8FA)],
                  ),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                const Expanded(
                    child: SizedBox(
                      child: SizedBox(
                          width: 350,
                          height: 350,
                          child: Image(
                            image: AssetImage('assets/logo.png'),
                          )),
                    ),
                    flex: 1),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: Get.width,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF6F5F5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            '????ng nh???p',
                            style: TextStyle(
                                color: Color(0xFF2D0C57),
                                fontFamily: 'RedHatDisplay',
                                fontSize: 28,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: StreamBuilder(
                              builder: (context, snapshot) => TextField(
                                controller: _emailInputCtrl,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelStyle: TextStyle(
                                      color: Color(0xFF9586A8),
                                      fontSize: 16,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400),
                                  labelText: 'Email',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 24,
                                    color: Color(0xFF9378FF),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD9D0E3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                        // color: Color(0xFFD9D0E3)
                                        color: Color(0xFF6C0EE4),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: StreamBuilder(
                              builder: (context, snapshot) => TextField(
                                controller: _passwordInputCtrl,
                                obscureText: !controller.showPass,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelStyle: const TextStyle(
                                      color: Color(0xFF9586A8),
                                      fontSize: 16,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400),
                                  labelText: 'M???t kh???u',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: Color(0xFF9378FF),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.showPassword();
                                    },
                                    icon: Icon(
                                      controller.showPass
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 24,
                                      color: Color(0xFF9378FF),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD9D0E3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                        // color: Color(0xFFD9D0E3)
                                        color: Color(0xFF6C0EE4),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                              width: Get.width,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ElevatedButton(
                                onPressed: handleFormSubmit,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 22, 0, 22),
                                    primary: const Color(0xFF9378FF)),
                                child: const Text('????NG NH???P',
                                    style: TextStyle(
                                        fontFamily: 'RedHatDisplay',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 18, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => ForgotPasswordScreen());
                                    },
                                    child: const Text(
                                      " Qu??n m???t kh???u ?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF9378FF),
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignupScreen());
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "B???n kh??ng c?? t??i kho???n?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9586A8),
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w400),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: " ????ng k??",
                                    style: TextStyle(
                                        color: Color(0xFF9378FF),
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(text: " ngay")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      );
    });
  }
}
