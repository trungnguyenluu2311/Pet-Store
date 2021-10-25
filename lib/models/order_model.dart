import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel {
  late String? id;
  late String idUser;
  late String nameUser;
  late String emailUser;
  late String phoneUser;
  late String addressUser;
  late String shippingMethod;
  late String paymentMethod;
  late String totals;
  late int? dateTimeOrder;
  late bool isCancel;
  late bool isCompleteUser;
  late bool isCompleteAdmin;
  late bool isWaitting;
  late bool isAccess;
  late bool isShipping;

  OrderModel({
    this.id,
    required this.idUser,
    required this.nameUser,
    required this.emailUser,
    required this.phoneUser,
    required this.addressUser,
    required this.shippingMethod,
    required this.paymentMethod,
    required this.totals,
    this.dateTimeOrder,
    required this.isCancel,
    required this.isCompleteUser,
    required this.isCompleteAdmin,
    required this.isWaitting,
    required this.isAccess,
    required this.isShipping,
  });

  OrderModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    idUser = documentSnapshot["iduser"];
    nameUser = documentSnapshot["nameuser"];
    emailUser = documentSnapshot["emailuser"];
    phoneUser = documentSnapshot["phoneuser"];
    addressUser = documentSnapshot["addressuser"];
    shippingMethod = documentSnapshot["shippingmethod"];
    paymentMethod = documentSnapshot["paymentmethod"];
    totals = documentSnapshot["totals"];
    dateTimeOrder = documentSnapshot["datetimeorder"];
    isCancel = documentSnapshot["iscancel"];
    isCompleteUser = documentSnapshot["iscompleteuser"];
    isCompleteAdmin = documentSnapshot["iscompleteadmin"];
    isWaitting = documentSnapshot["iswaitting"];
    isAccess = documentSnapshot["isaccess"];
    isShipping = documentSnapshot["isshipping"];

  }

  OrderModel.fromQueryDocumentSnapshot({required QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    id = queryDocSnapshot.id;
    idUser = (data as dynamic)["iduser"];
    nameUser = (data as dynamic)["nameuser"];
    emailUser = (data as dynamic)["emailuser"];
    phoneUser = (data as dynamic)["phoneuser"];
    addressUser = (data as dynamic)["addressuser"];
    shippingMethod = (data as dynamic)["shippingmethod"];
    paymentMethod = (data as dynamic)["paymentmethod"];
    totals = (data as dynamic)["totals"];
    dateTimeOrder = (data as dynamic)["datetimeorder"];
    isCancel = (data as dynamic)["iscancel"];
    isCompleteUser = (data as dynamic)["iscompleteuser"];
    isCompleteAdmin = (data as dynamic)["iscompleteadmin"];
    isWaitting = (data as dynamic)["iswaitting"];
    isAccess = (data as dynamic)["isaccess"];
    isShipping = (data as dynamic)["isshipping"];
  }

}
