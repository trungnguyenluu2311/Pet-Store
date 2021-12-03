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
        // iconTheme: IconThemeData(color: Colors.grey[50]),
        centerTitle: true,
        title: Text("Quên mật khẩu", style: TextStyle(fontSize: 30,color: Colors.grey[50])),
        backgroundColor: Color(0xFF085B6E),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: editController,
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Nhập vào email",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[50]!),
                  backgroundColor: Color(0xFF085B6E),
                ),
                onPressed: () {
                  resetPassword();
                },
                child: const Text(
                  "Cài lại mật khẩu",
                  style: TextStyle(color: Colors.white,fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetPassword(){
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Get.snackbar("Lỗi", "Email không hợp lệ");
      return;
    }
    Get.find<AuthController>().forgotPassword(editController.text);
  }
}