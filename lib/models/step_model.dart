import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StepModel {
  // String? documentId;
  late String title;
  late String text;
  late String imageURL;

  StepModel({
    required this.title,
    required this.text,
    required this.imageURL,
  });

  StepModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    // documentId = documentSnapshot.id;
    title = documentSnapshot["title"];
    text = documentSnapshot["text"];
    imageURL = documentSnapshot["imageURL"];
  }

  StepModel.fromMap({required Map stepMap}) {
    title = stepMap["title"];
    text = stepMap["text"];
    imageURL = stepMap["imageURL"];
  }
}
