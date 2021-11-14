import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ChangeInfo extends StatefulWidget {
  final String tempName;
  final String tempPhone;

  ChangeInfo(this.tempName, this.tempPhone);

  @override
  _ChangeInfoState createState() =>
      _ChangeInfoState(this.tempName, this.tempPhone);
}

class _ChangeInfoState extends State<ChangeInfo>
    with SingleTickerProviderStateMixin {
  _ChangeInfoState(this.tempName, this.tempPhone);

  String tempName;
  String tempPhone;
  final AuthController _userCtrl = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameInputCtrl = TextEditingController();

  final TextEditingController _phoneInputCtrl = TextEditingController();

  void handleFormSubmit(context) async {
    if (_nameInputCtrl.text.isNotEmpty && _phoneInputCtrl.text.isNotEmpty) {
      _userCtrl.updateUser(
        id: _userCtrl.user!.uid,
        name: _nameInputCtrl.text.trim(),
        phone: _phoneInputCtrl.text.trim(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _nameInputCtrl.text = tempName;
    _phoneInputCtrl.text = tempPhone;
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
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF2D0C57),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFAF9FE),
          elevation: 0.5,
          title: const Text("Đổi thông tin",
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
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Color(0xFFFAF9FE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Họ và tên",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D0C57),
                    )),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameInputCtrl,
                  cursorColor: const Color(0xFF7203FF),
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'RedHatDisplay'),
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
                const Text("Số điện thoại",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D0C57),
                    )),
                const SizedBox(height: 12),
                TextField(
                  controller: _phoneInputCtrl,
                  cursorColor: const Color(0xFF7203FF),
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'RedHatDisplay'),
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
      ),
    );
  }
}
