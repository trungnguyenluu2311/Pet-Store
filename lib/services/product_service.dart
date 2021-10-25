import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:intl/intl.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firestorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> fetchProducts() {
    return _firestore.collection("products").snapshots();
  }

  Stream<QuerySnapshot> searchProducts(String nameProduct) {
    return _firestore.collection("products").orderBy("namelowercase").startAt([nameProduct]).endAt([nameProduct + '\uf8ff']).snapshots();
  }

  Stream<DocumentSnapshot> fetchProduct(String productId) {
    return _firestore.collection("products").doc(productId.toString()).snapshots();
  }

  int countPro(){
    int temp = 0;
    _firestore.collection("products").get().then((value){
      temp++;
    });
    print("$temp");
    return temp;
  }
}
