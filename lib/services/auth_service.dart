import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;

  Future<UserCredential> registerUser(String email, String password) async {
    late UserCredential _authResult;
    try {
      _authResult = await _fireAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim(),);
    } catch(e){
      Get.snackbar(
        "Lỗi tạo tài khoản",
        "Có thể email bạn đã được sử dụng",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
    return _authResult;
  }

  Future<UserCredential?> loginUser(String email, String password) async {
    late UserCredential _authResult;
    if(email == "admin@gmail.com"){
      Get.snackbar(
        "Lỗi đăng nhập",
        "Bạn không thể đăng nhập với email này",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
      return null;
    }
    else{try {
      _authResult = await _fireAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } catch(e){
      Get.snackbar(
        "Lỗi đăng nhập",
        "Tài khoản hoặc mật khẩu không đúng",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
    return _authResult;}
  }

  Future<void> signOutUser() async {
    await _fireAuth.signOut();
  }

  Future<void> forgotPassword(String email) async {
    await _fireAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> changePassword(String oldpassword) async{
    User currentUser = _fireAuth.currentUser!;
    late UserCredential _authResult;
    try {
      _authResult = await currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: currentUser.email ?? '',
              password: oldpassword),
      );
    } catch(e){
      Get.snackbar(
        "Lỗi",
        "Không biết lỗi gì nữa",//:v
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
    return _authResult;
    //Create an instance of the current user.
    // User currentUser = _fireAuth.currentUser;
    //
    // UserCredential authResult = await currentUser.reauthenticateWithCredential(
    //   EmailAuthProvider.credential(email: currentUser.email, password: oldpassword)
    // );
    //Pass in the password to updatePassword.
    // authResult..updatePassword(newpassword).then((_){
    //   print("Successfully changed password");
    // }).catchError((error){
    //   print("Password can't be changed" + error.toString());
    //   //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    // });
  }
}