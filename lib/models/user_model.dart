import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  late String? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? address;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.address,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    phone = documentSnapshot["phone"];
    address = documentSnapshot["address"];
  }

  UserModel.fromQueryDocumentSnapshot({required QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    id = queryDocSnapshot.id;
    name = (data as dynamic)["name"];
    email = (data as dynamic)["email"];
    phone = (data as dynamic)["phone"];
    address = (data as dynamic)["address"];
  }

  // UserModel.fromQueryDocumentSnapshot({QueryDocumentSnapshot queryDocSnapshot}) {
  //   var data = queryDocSnapshot.data();
  //   id = data["id"];
  //   name = data["name"];
  //   email = data["email"];
  //   phone = data["phone"];
  //   address = data["address"];
  // }
}
