import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/controllers/utilities_controller.dart';
import 'package:get/get.dart';

class SignupScreen extends GetWidget<UtilitiesController> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailInputCtrl = TextEditingController();
  final TextEditingController _passwordInputCtrl = TextEditingController();
  final TextEditingController _confirmpasswordInputCtrl = TextEditingController();
  final TextEditingController _nameInputCtrl = TextEditingController();
  final TextEditingController _phoneInputCtrl = TextEditingController();

  final AuthController _authCtrl = Get.find();

  handleFormSignUp() async {
    if(_passwordInputCtrl.text == ''){
      Get.snackbar("Lỗi", "Mật khẩu để trống");
    }
    else if(_passwordInputCtrl.text == _confirmpasswordInputCtrl.text){
      await _authCtrl.register(_nameInputCtrl.text,_emailInputCtrl.text,_phoneInputCtrl.text,_passwordInputCtrl.text,"");
    }
    else{
      Get.snackbar("Lỗi", "Mật khẩu không trùng nhau");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UtilitiesController>(
      builder: (controller){
        return Scaffold(
          extendBodyBehindAppBar: true,
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Color(0xFF2D0C57)),
            elevation: 0,
          ),
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
                Column(children: [
                  const Expanded(child: SizedBox(), flex: 1),
                  Expanded(
                    flex: 3,//
                    child: Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF6F5F5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Đăng ký',
                              style: TextStyle(
                                  color: Color(0xFF2D0C57),
                                  fontFamily: 'RedHatDisplay',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 00),
                              child: TextField(
                                controller: _nameInputCtrl,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelText: 'Họ và tên',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF9586A8),
                                    fontSize: 16,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
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
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 00),
                              child: TextField(
                                controller: _phoneInputCtrl,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelText: 'Số điện thoại',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF9586A8),
                                    fontSize: 16,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.phone_outlined,
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
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 00),
                              child: TextField(
                                controller: _emailInputCtrl,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF9586A8),
                                    fontSize: 16,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w400,
                                  ),
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
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                obscureText: true,
                                controller: _passwordInputCtrl,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelText: 'Mật khẩu',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF9586A8),
                                    fontSize: 16,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                obscureText: true,
                                controller: _confirmpasswordInputCtrl,
                                decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelText: 'Xác nhận mật khẩu',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF9586A8),
                                    fontSize: 16,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                            const SizedBox(height: 20),
                            Container(
                                width: Get.width,
                                padding:
                                const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ElevatedButton(
                                  onPressed: () => handleFormSignUp(),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 22, 0, 22),
                                      primary: const Color(0xFF9378FF)),
                                  child: const Text('ĐĂNG KÝ',
                                      style: TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                )),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: "Bạn đã có tài khoản?",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9586A8),
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " Đăng nhập",
                                      style: TextStyle(
                                          color: Color(0xFF9378FF),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(text: " ngay")
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(height: 100),
                          ],
                        ),
                      ),),
                  )
                ]),
              ],
            ),
          ),
        );
      }
    );
  }
}
