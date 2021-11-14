import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass>
    with SingleTickerProviderStateMixin {
  final AuthController _userCtrl = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _oldpassInputCtrl = TextEditingController();
  final TextEditingController _newpassInputCtrl = TextEditingController();
  final TextEditingController _newpassagainInputCtrl = TextEditingController();

  void handleFormSubmit(context) async {
    if (_oldpassInputCtrl.text.isNotEmpty &&
        _newpassInputCtrl.text.isNotEmpty &&
        _newpassagainInputCtrl.text.isNotEmpty &&
        (_newpassInputCtrl.text == _newpassagainInputCtrl.text)) {
      _userCtrl.changepasswword(_oldpassInputCtrl.text, _newpassInputCtrl.text);
    } else if (_oldpassInputCtrl.text == _newpassInputCtrl.text) {
      Get.snackbar("Lỗi", "Mật khẩu mới giống mật khẩu cũ");
    } else if (_newpassInputCtrl.text != _newpassagainInputCtrl.text) {
      Get.snackbar("Lỗi", "Mật khẩu nhập lại không đúng");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Added
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFFAF9FE),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF2D0C57),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFAF9FE),
          elevation: 0.5,
          title: const Text("Đổi mật khẩu",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D0C57),
              )),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.save,
                size: 24,
              ),
              onPressed: () => handleFormSubmit(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Mật khẩu cũ",
                  style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
              const SizedBox(height: 12),
              TextField(
                controller: _oldpassInputCtrl,
                cursorColor: const Color(0xFF7203FF),
                style:
                    const TextStyle(fontSize: 18, fontFamily: 'RedHatDisplay'),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF7203FF),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFFD9D0E3))),
                  isDense: true,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Mật khẩu mới",
                  style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
              const SizedBox(height: 12),
              TextField(
                controller: _newpassInputCtrl,
                cursorColor: const Color(0xFF7203FF),
                style:
                    const TextStyle(fontSize: 18, fontFamily: 'RedHatDisplay'),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF7203FF),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFFD9D0E3))),
                  isDense: true,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _newpassInputCtrl,
                cursorColor: const Color(0xFF7203FF),
                style:
                const TextStyle(fontSize: 18, fontFamily: 'RedHatDisplay'),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF7203FF),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFFD9D0E3))),
                  isDense: true,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              const Text("Nhập lại mật khẩu mới",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D0C57),
                  )),
              const SizedBox(height: 12),
              TextField(
                controller: _newpassagainInputCtrl,
                cursorColor: const Color(0xFF7203FF),
                style:
                    const TextStyle(fontSize: 18, fontFamily: 'RedHatDisplay'),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFF7203FF),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFFD9D0E3))),
                  isDense: true,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
