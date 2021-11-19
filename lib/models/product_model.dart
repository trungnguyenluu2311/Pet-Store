import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  List<Product> products;

  ProductModel({required this.products});
}

class Product{
  late String? id;
  late String name;
  late String namelowercase;
  late String price;
  late String discount;
  late String pathImage;
  late String? quantum;
  late String? howtouse;
  late String? components;
  late String? tag;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.pathImage,
    this.quantum,
    this.howtouse,
    this.components,
    this.tag
  });

  Product.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    namelowercase = documentSnapshot["namelowercase"];
    price = documentSnapshot["price"];
    discount = documentSnapshot["discount"];
    pathImage = documentSnapshot["path"];
    quantum = documentSnapshot["quantum"];
    howtouse =  documentSnapshot["howtouse"];
    components =  documentSnapshot["components"];
    tag = documentSnapshot["tag"];
  }

  Product.fromDocumentSnapshotFav({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    namelowercase = documentSnapshot["namelowercase"];
    price = documentSnapshot["price"];
    discount = documentSnapshot["discount"];
    pathImage = documentSnapshot["path"];
    quantum = documentSnapshot["quantum"];
    howtouse =  documentSnapshot["howtouse"];
    components =  documentSnapshot["components"];
    tag = documentSnapshot["tag"];
  }

  Product.fromDocumentSnapshotForcart({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    price = documentSnapshot["price"];
    discount = documentSnapshot["discount"];
    pathImage = documentSnapshot["path"];
    quantum = documentSnapshot["quantum"];
  }

  Product.fromQueryDocumentSnapshotForcart({required QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    id = queryDocSnapshot.id;
    name = (data as dynamic)["name"];
    price = (data as dynamic)["price"];
    discount = (data as dynamic)["discount"];
    pathImage = (data as dynamic)["path"];
    quantum = (data as dynamic)["quantum"];
  }

  Product.fromQueryDocumentSnapshot({required QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    id = queryDocSnapshot.id;
    name = (data as dynamic)["name"];
    namelowercase = (data as dynamic)["namelowercase"] ;
    price = (data as dynamic)["price"];
    discount = (data as dynamic)["discount"];
    pathImage = (data as dynamic)["path"];
    quantum = (data as dynamic)["quantum"];
    howtouse =  (data as dynamic)["howtouse"];
    components =  (data as dynamic)["components"];
    tag =  (data as dynamic)["tag"];
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json["name"];
    namelowercase = json["namelowercase"];
    price = json["price"];
    discount = json["discount"];
    pathImage = json["path"];
    quantum = json["quantum"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['namelowercase'] = this.namelowercase;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['path'] = this.pathImage;
    data['quantum'] = this.quantum;
    return data;
  }
}
