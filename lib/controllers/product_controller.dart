import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:flutter_project/services/product_service.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProductController extends GetxController {
  RxInt _productListCount = 0.obs;
  RxInt get productListCount => _productListCount;
  void setproductListCount(int val) => _productListCount.value = val;

  final ProductService _productService = ProductService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void updateScreen(){
    update();
  }

  Stream<QuerySnapshot> fetchProducts() {
    Stream<QuerySnapshot> qSnapStream =
    _productService.fetchProducts();
    return qSnapStream;
  }

  Stream<QuerySnapshot> searchProducts(String nameProduct) {
    Stream<QuerySnapshot> qSnapStream =
    _productService.searchProducts(nameProduct);
    return qSnapStream;
  }

  Stream<DocumentSnapshot> fetchProduct(String id) {
    Stream<DocumentSnapshot> dSnapStream =
    _productService.fetchProduct(id);
    return dSnapStream;
  }
}
