import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_project/bindings/Instancebinding.dart';
import 'package:flutter_project/bindings/isSignin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // InstanceBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InstanceBinding(),
      title: 'Pet Shop',
      home: SafeArea(child: IsSignIn(),),
      // home: Splash(),
    );
  }
}

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

