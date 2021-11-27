import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentModel {
  late String? id;
  late String? name;
  late int? dateTimeCmt;
  late String? content;

  CommentModel({
    this.id,
    required this.name,
    this.dateTimeCmt,
    required this.content,
  });

  CommentModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    dateTimeCmt = documentSnapshot["datetimecmt"];
    content = documentSnapshot["content"];
  }

  CommentModel.fromQueryDocumentSnapshot({required QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot.data();
    id = queryDocSnapshot.id;
    name = (data as dynamic)["name"];
    dateTimeCmt = (data as dynamic)["datetimecmt"];
    content = (data as dynamic)["content"];
  }
}
