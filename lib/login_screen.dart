import 'package:flutter/material.dart';
import 'package:flutter_project/home_screen.dart';
import 'package:flutter_project/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                    flex: 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF6F5F5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                  color: Color(0xFF120E21),
                                  fontFamily: 'RedHatDisplay',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 36),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: InputDecoration(
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
                            const SizedBox(height: 12),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(26, 12, 0, 12),
                                  labelStyle: TextStyle(
                                      color: Color(0xFF9586A8),
                                      fontSize: 16,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400),
                                  labelText: 'Mật khẩu',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.password_outlined,
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
                            const SizedBox(height: 36),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 22, 0, 22),
                                      primary: const Color(0xFF9378FF)),
                                  child: const Text('ĐĂNG NHẬP',
                                      style: TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                )),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()));
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: "Bạn không có tài khoản?",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9586A8),
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " Đăng ký",
                                      style: TextStyle(
                                          color: Color(0xFF9378FF),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(text: " ngay")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
