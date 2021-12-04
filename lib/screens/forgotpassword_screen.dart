import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project/controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF2D0C57),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFAF9FE),
        elevation: 0.5,
        title: const Text("Quên mật khẩu",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D0C57),
            )),
      ),
      body: Container(
        color: const Color(0xFFFAF9FE),
        margin: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: editController,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(26, 12, 0, 12),
                labelStyle: TextStyle(
                    color: Color(0xFF9586A8),
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w400),
                labelText: 'Email',
                hintText: 'Nhập vào email',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24,
                  color: Color(0xFF9378FF),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD9D0E3)),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      // color: Color(0xFFD9D0E3)
                      color: Color(0xFF6C0EE4),
                    )),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: (){
                    resetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      primary: const Color(0xFF9378FF)),
                  child: const Text('CÀI LẠI MẬT KHẨU',
                      style: TextStyle(
                          fontFamily: 'RedHatDisplay',
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                )),
          ],
        ),
      ),
    );
  }

  void resetPassword() {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Get.snackbar("Lỗi", "Email không hợp lệ");
      return;
    }
    Get.find<AuthController>().forgotPassword(editController.text);
  }
}
