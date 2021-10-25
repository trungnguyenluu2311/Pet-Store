import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/order_model.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/models/user_model.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/services/user_service.dart';
import 'package:flutter_project/controllers/utilities_controller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;//Thử lấy dữ liệu loại

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value!;
  User setUser(User user) => _firebaseUser.value = user;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_fireAuth.authStateChanges());
    // fetchUser();
  }


  Stream<DocumentSnapshot> fetchUser() {
    Stream<DocumentSnapshot> dSnapStream =
    _userService.fetchUser(user!.uid);
    return dSnapStream;
  }

  void _createUser(UserCredential _authResult,String name,String phone, String address) async {
    try {
      UserModel user = UserModel(
        id: _authResult.user!.uid,
        email: _authResult.user!.email,
        name: name,
        phone: phone,
        address: address,
      );
      await _userService.createNewUser(user);

      setUser(_fireAuth.currentUser!);
      Get.offAll(MainScreen());
      Get.snackbar("","Tạo tài khoản thành công");
    } catch (e) {
      Get.snackbar("Lỗi",e.toString());
    }
  }

  void _getUser(UserCredential _authResult) async {
    try {
      UserModel user = UserModel(
        id: _authResult.user!.uid,
        email: _authResult.user!.email,
      );

      await _userService.getUser(user);
      Get.offAll(MainScreen());
      Get.snackbar("","Đăng nhập thành công");

      // Get.offAll(HomeScreen());

    } catch (e) {
      Get.snackbar("Lỗi",e.toString());
    }
  }

  Future<void> register(String name,String email,String phone, String password,String address) async {
    try {
      UserCredential _authResult =
      await _authService.registerUser(email.trim(), password.trim());
      if (_authResult != null && _authResult.user != null) {
        _createUser(_authResult,name,phone,address);
      }
    } catch (e) {
      // Get.showSnackbar(snackbar)
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential _authResult =
      (await _authService.loginUser(email.trim(), password.trim()))!;

      if (_authResult != null && _authResult.user != null) {
        _getUser(_authResult);
      }
    } catch (e) {
      // Get.showSnackbar(snackbar)
    }
  }

  Future<void> changepasswword(String oldpassword,String newpassword) async {
    try{
      UserCredential _authResult =
      await _authService.changePassword(oldpassword);

      if(_authResult != null && _authResult.user != null){
        _fireAuth.currentUser!.updatePassword(newpassword).then((_){
            Get.back();
            Get.snackbar("Thông báo","Đổi mật khẩu thành công");
          }).catchError((error){
            Get.snackbar("Lỗi","Có gì đó không ổn");
            //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
          });
      }
    } catch(e){

    }
  }

  void signOutUser() async {
    try {
      await _authService.signOutUser();
      UtilitiesController controller = Get.find();
      controller.tabIndex = 0;
      controller.showPass = false;
      // Get.offAll(IsSignedIn());
      // Get.offAll(LoginScreen());
      Get.off(() => LoginScreen());
    } catch (e) {
      // Get.showSnackbar(snackbar)
    }
  }

  void forgotPassword(String email) async {
    try {
      await _authService.forgotPassword(email);
      Get.back();
      Get.snackbar("Thông báo","Đường link thay đổi mật khẩu đã được gửi tới email bạn vui lòng kiểm tra");
      // Get.snackbar("Error","Enter valid email");
    } catch (e) {
      // Get.showSnackbar(snackbar)
    }
  }


  void updateUser({
    required String id,
    required String name,
    required String phone,
  }) async {
    try {
      UserModel _user = UserModel(
        id: user!.uid,
        name: name,
        phone: phone,
      );

      await _userService.updateUser(_user);
      Get.back();
      Get.snackbar("Thông báo","Thay đổi thông tin cá nhân thành công");
    } catch (e) {
      Get.snackbar("Lỗi","Có gì đó không ổn");
    }
  }

  void updateAddressUser({
    required String id,
    required String address
  }) async {
    try {
      UserModel _user = UserModel(
        id: user!.uid,
        address: address,
      );

      await _userService.updateAddressUser(_user);
      Get.back();
      Get.snackbar("Thông báo","Đổi địa chỉ thành công");
    } catch (e) {
      Get.snackbar("Lỗi","Có gì đó không ổn");
    }
  }
  //product trong cart

  Stream<QuerySnapshot> fetchProductsFromCartUser(){
    Stream<QuerySnapshot> qSnapStream =
    _userService.fetchProductsFromCartUser() ;
    return qSnapStream;
  }

  Future<void> addProductToCart(Product product) async {
    try {
      Product productTemp = Product(
        id: product.id,
        name: product.name,
        price: product.price,
        discount: product.discount,
        pathImage: product.pathImage,
      );
      await _userService.addProductToCart(productTemp);
      // Get.back();
      // Get.snackbar("","Add Product Successful");
    } catch (e) {
      Get.snackbar("Lỗi",e.toString());
    }
  }

  Future<void> addProductInCart(Product product) async {
    try {
      Product productTemp = Product(
        id: product.id,
        name: product.name,
        price: product.price,
        discount: product.discount,
        pathImage: product.pathImage,
      );
      // print("${product.id}");
      await _userService.addProductInCart(productTemp);
    } catch (e) {
      Get.snackbar("Lỗi",e.toString());
    }
  }

  Future<void> removeProductInCart(Product product) async {
    try {
      Product productTemp = Product(
        id: product.id,
        name: product.name,
        price: product.price,
        discount: product.discount,
        pathImage: product.pathImage,
      );
      await _userService.removeProductInCart(productTemp);
    } catch (e) {
      Get.snackbar("Lỗi",e.toString());
    }
  }

  Future<void> deleteProductFromCart(Product product) async {
    await _userService.deleteProductFromCart(product);
    // Get.snackbar("","Delete Product $name Successful");
  }
  // thanh toán

  Future<void> paythebill(UserModel user,String totals,String shippingmethod,String paymentmethod) async {
    try {
      OrderModel orderModel = OrderModel(
        idUser: user.id!,
        nameUser: user.name!,
        emailUser: user.email!,
        phoneUser: user.phone!,
        addressUser: user.address!,
        shippingMethod: shippingmethod,
        paymentMethod: paymentmethod,
        totals: totals,
        isCancel: false,
        isCompleteUser: false,
        isCompleteAdmin: false,
        isWaitting: true,
        isAccess: false,
        isShipping: false,
      );
      await _userService.paythebill(orderModel);
    } catch (e) {
      Get.snackbar("Lỗi",e.toString());
    }
  }
  // lịch sử mua hàng
  Stream<QuerySnapshot> fetchOrdersAll() {
    Stream<QuerySnapshot> qSnapStream =
    _userService.fetchOrdersAll();
    return qSnapStream;
  }

  Stream<QuerySnapshot> fetchOrdersCancel() {
    Stream<QuerySnapshot> qSnapStream =
    _userService.fetchOrdersCancel();
    return qSnapStream;
  }

  Stream<QuerySnapshot> fetchOrdersComplete() {
    Stream<QuerySnapshot> qSnapStream =
    _userService.fetchOrdersComplete();
    return qSnapStream;
  }

  Stream<QuerySnapshot> fetchOrdersWaitting() {
    Stream<QuerySnapshot> qSnapStream =
    _userService.fetchOrdersWaitting();
    return qSnapStream;
  }

  Stream<DocumentSnapshot> fetchOrder(String idorrder){
    Stream<DocumentSnapshot> qSnapStream =
    _userService.fetchOrder(idorrder) ;
    return qSnapStream;
  }

  Stream<QuerySnapshot> fetchProductsFromOrder(String idorrder){
    Stream<QuerySnapshot> qSnapStream =
    _userService.fetchProductsFromOrder(idorrder) ;
    return qSnapStream;
  }

  Future<void> cancelOrder(String idorder) async {
    await _userService.cancelOrder(idorder);
  }

  Future<void> completeOrder(String idorder) async {
    await _userService.completeOrder(idorder);
  }
}
