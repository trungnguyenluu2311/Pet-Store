import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeAddress extends StatefulWidget {
  final String tempAddress;

  ChangeAddress(this.tempAddress);

  @override
  _ChangeAddressState createState() => _ChangeAddressState(this.tempAddress);
}

class _ChangeAddressState extends State<ChangeAddress>
    with SingleTickerProviderStateMixin {
  String tempAddress;

  _ChangeAddressState(this.tempAddress);

  final AuthController _userCtrl = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _addressInputCtrl = TextEditingController();

  void handleFormSubmit(context) async {
    if (_addressInputCtrl.text.isNotEmpty) {
      _userCtrl.updateAddressUser(
        id: _userCtrl.user!.uid,
        address: _addressInputCtrl.text.trim(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _addressInputCtrl.text = tempAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF2D0C57),
        ),
        centerTitle: true,
        elevation: 0.5,
        title: const Text("Đổi địa chỉ",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D0C57),
            )),
        backgroundColor: const Color(0xFFFAF9FE),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(
                Icons.save,
                size: 24,
              ),
              onPressed: () => handleFormSubmit(context),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFFAF9FE),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Địa chỉ',
                style: TextStyle(
                  color: Color(0xFF2D0C57),
                  fontFamily: 'RedHatDisplay',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                maxLines: 3,
                controller: _addressInputCtrl,
                cursorColor: const Color(0xFF7203FF),
                style: const TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD9D0E3)),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFF7203FF))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
