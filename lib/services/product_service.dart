import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project/models/user_model.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:intl/intl.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firestorage = FirebaseStorage.instance;

  //cmt
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  //
  Stream<QuerySnapshot> fetchProducts() {
    return _firestore.collection("products").snapshots();
  }

  Stream<QuerySnapshot> fetchProductsFood() {
    return _firestore
        .collection("products")
        .where('tag', isEqualTo: "food")
        .snapshots();
  }

  Stream<QuerySnapshot> fetchProductsToy() {
    return _firestore
        .collection("products")
        .where('tag', isEqualTo: "toy")
        .snapshots();
  }

  Stream<QuerySnapshot> fetchProductsMedic() {
    return _firestore
        .collection("products")
        .where('tag', isEqualTo: "medic")
        .snapshots();
  }

  Stream<QuerySnapshot> searchProducts(String nameProduct) {
    return _firestore
        .collection("products")
        .orderBy("namelowercase")
        .startAt([nameProduct]).endAt([nameProduct + '\uf8ff']).snapshots();
  }

  Stream<DocumentSnapshot> fetchProduct(String productId) {
    return _firestore
        .collection("products")
        .doc(productId.toString())
        .snapshots();
  }

  int countPro() {
    int temp = 0;
    _firestore.collection("products").get().then((value) {
      temp++;
    });
    print("$temp");
    return temp;
  }

  //cmt
  Future<void> Addcmt(String productId, String content) async {
    final snapShot = await _firestore
        .collection("users")
        .doc(_fireAuth.currentUser!.uid)
        .get();
    final UserModel user =
        UserModel.fromDocumentSnapshot(documentSnapshot: snapShot);
    await _firestore
        .collection("products")
        .doc(productId)
        .collection("comments")
        .add({
      "name": user.name,
      "datetimecmt": DateTime.now().toUtc().millisecondsSinceEpoch,
      "content": content
    });
  }

  Stream<QuerySnapshot> fetchCmt(String productId) {
    return _firestore
        .collection("products")
        .doc(productId)
        .collection("comments")
        .snapshots();
  }
}
