import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/models/order_model.dart';
import 'package:flutter_project/models/user_model.dart';
import 'package:flutter_project/screens/change_address_screen.dart';
import 'package:flutter_project/screens/change_info_user_screen.dart';
import 'package:flutter_project/screens/change_pass_screen.dart';
import 'package:flutter_project/screens/transaction_history_screen.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GetBuilder<AuthController>(
        builder: (_) => StreamBuilder<DocumentSnapshot>(
          stream: Get.find<AuthController>().fetchUser(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final UserModel user = UserModel.fromDocumentSnapshot(
                documentSnapshot: snapshot.data!);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.5,
                backgroundColor: const Color(0xFFFAF9FE),
                title: const Text('Người dùng',
                    style: TextStyle(
                        color: Color(0xFF2D0C57),
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w700,
                        fontSize: 34)),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    const CircleAvatar(
                        backgroundColor: Color(0xFF7203FF),
                        radius: 40,
                        child:
                            Icon(Icons.person, size: 60, color: Colors.white)),
                    const SizedBox(height: 6),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onTap: () {
                        Get.to(()=>ChangeInfo(user.name!, user.phone!));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Text(user.name!,
                                style: const TextStyle(
                                    color: Color(0xFF2D0C57),
                                    fontSize: 18,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w700)),
                            Text(
                              user.email!,
                              style: const TextStyle(
                                  color: Color(0xFF9586A8),
                                  fontSize: 18,
                                  fontFamily: 'RedHatDisplay',
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE2CBFF),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text(
                                'CHỈNH SỬA HỒ SƠ',
                                style: TextStyle(
                                    color: Color(0xFF2D0C57),
                                    fontSize: 14,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const Divider(
                    //   indent: 60,
                    //   endIndent: 60,
                    // ),
                    GetBuilder<AuthController>(
                        builder: (_) => StreamBuilder<QuerySnapshot>(
                            stream: Get.find<AuthController>()
                                .fetchOrdersComplete(),
                            builder: (context, stream) {
                              if (stream.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (stream.hasError) {
                                return Center(
                                    child: Text(stream.error.toString()));
                              }
                              QuerySnapshot querySnapshot = stream.data!;
                              double totalsPrice() {
                                double tempcounter = 0;
                                for (int i = 0; i < querySnapshot.size; i++) {
                                  final item1 = querySnapshot.docs[i];
                                  final OrderModel order =
                                      OrderModel.fromQueryDocumentSnapshot(
                                          queryDocSnapshot: item1);
                                  tempcounter += (double.parse(order.totals));
                                }
                                return tempcounter;
                              }

                              return Column(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                    text:
                                        'Tổng tiền đã tiêu: ${formatter.format(totalsPrice())}',
                                    style: const TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 16,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500),
                                    children: const [
                                      TextSpan(
                                          text: ' đ',
                                          style: TextStyle(
                                              color: Color(0xFF9586A8),
                                              fontSize: 14))
                                    ],
                                  )),
                                  Text(
                                      'Tổng đơn thành công: ${querySnapshot.size}',
                                      style: const TextStyle(
                                          color: Color(0xFF2D0C57),
                                          fontSize: 16,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 12)
                                ],
                              );
                            })),
                    const Divider(
                        indent: 12, endIndent: 12, height: 0, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          _tranHisScreen();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: const [
                              Icon(Icons.note_rounded,
                                  size: 16, color: Color(0xFF9586A8)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text('Lịch sử mua hàng',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 24, color: Color(0xFF9586A8))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                        indent: 12, endIndent: 12, height: 0, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          Get.to(()=>ChangeAddress(user.address!));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: const [
                              Icon(Icons.location_on,
                                  size: 16, color: Color(0xFF9586A8)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text('Đổi địa chỉ',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 24, color: Color(0xFF9586A8))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                        indent: 12, endIndent: 12, height: 0, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          Get.to(()=>ChangePass());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: const [
                              Icon(Icons.lock,
                                  size: 16, color: Color(0xFF9586A8)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text('Đổi mật khẩu',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 24, color: Color(0xFF9586A8))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                        indent: 12, endIndent: 12, height: 0, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          Get.find<AuthController>().signOutUser();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: const [
                              Icon(Icons.logout,
                                  size: 16, color: Color(0xFF9586A8)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text('Đăng xuất',
                                    style: TextStyle(
                                        color: Color(0xFFCF2C0A),
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 24, color: Color(0xFF9586A8))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                        indent: 12, endIndent: 12, height: 0, thickness: 1),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    //   child: OutlinedButton(
                    //     style: OutlinedButton.styleFrom(
                    //         backgroundColor: Color(0xFF0D9ABA)),
                    //     onPressed: () {
                    //       Get.find<AuthController>().signOutUser();
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Đăng xuất",
                    //           style: TextStyle(
                    //             color: Colors.grey[50],
                    //             fontSize: 20,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

void _tranHisScreen() {
    Get.to(()=>TranHis());
  }

/*void _changePass(){
    Get.to(()=>ChangePass());
  }*/
}
