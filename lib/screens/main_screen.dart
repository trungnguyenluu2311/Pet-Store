import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/user_info_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/models/user_model.dart';
import 'package:flutter_project/models/product_model.dart';
// import 'package:flutter_project/screens/notification_screen.dart';
// import 'package:flutter_project/screens/payment_screen.dart';
// import 'package:flutter_project/screens/search_screen.dart';
// import 'package:flutter_project/screens/user_info_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/controllers/utilities_controller.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'cart_screen.dart';


class MainScreen extends GetWidget<UtilitiesController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late double totalstemp;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UtilitiesController>(
        builder: (controller){
          return Scaffold(
            key: _scaffoldKey,
            body: GetBuilder<UtilitiesController>(
              init: UtilitiesController(),
              builder: (s) => IndexedStack(
                index: controller.tabIndex,
                children:[
                  HomeScreen(),
                  UserInfo(),
                  CartScreen()
                  /*UserInfo(),
                  CartScreen(),*/
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                  border: Border(top: BorderSide(color: Color(0xFFD9D0E3)))
              ),
              child: BottomNavigationBar(
                currentIndex: controller.tabIndex,
                onTap: controller.changeTabIndex,
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                iconSize: 24,
                selectedItemColor: const Color(0xFF7203FF),
                unselectedItemColor: const Color(0xFF9586A8),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Icon(Icons.home_outlined),
                      ),
                      label: ''
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.medical_services_outlined),
                  //   label: ''
                  // ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: ''
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: ''
                  ),
                ],
              ),
            ),
          );}
    );
  }

  // void _payment() {
  //   if(totalstemp == 0){
  //     Get.snackbar("Thông báo", "Không có sản phẩm trong giỏ hàng");
  //   }
  //   else{
  //     Get.to(()=>Payment());
  //   }
  // }
}








// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedItem = 0;
//   final tabs = [
//     const HomeScreen(),
//     // Container(),
//     Container(),
//     Container(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: tabs[_selectedItem],
//         bottomNavigationBar: Container(
//           decoration: const BoxDecoration(
//             border: Border(top: BorderSide(color: Color(0xFFD9D0E3)))
//           ),
//           child: BottomNavigationBar(
//             currentIndex: _selectedItem,
//             backgroundColor: Colors.white,
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             iconSize: 24,
//             selectedItemColor: const Color(0xFF7203FF),
//             unselectedItemColor: const Color(0xFF9586A8),
//             type: BottomNavigationBarType.fixed,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   child: Icon(Icons.home_outlined),
//                 ),
//                 label: ''
//               ),
//               // BottomNavigationBarItem(
//               //   icon: Icon(Icons.medical_services_outlined),
//               //   label: ''
//               // ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_outline),
//                 label: ''
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_cart_outlined),
//                 label: ''
//               ),
//             ],
//             onTap: (index) {
//               setState(() {
//                 _selectedItem = index;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
