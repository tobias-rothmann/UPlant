import 'package:cloud_firestore/cloud_firestore.dart';
import 'step_model.dart';

class GuideModel {
  // String? documentId;
  late String title;
  late String infoText;
  late String imageURL;
  late List<StepModel> steps;

  GuideModel({
    required this.title,
    required this.infoText,
    required this.imageURL,
    required this.steps,
  });

  GuideModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    // documentId = documentSnapshot.id;
    title = documentSnapshot["title"];
    infoText = documentSnapshot["infoText"];
    imageURL = documentSnapshot["imageURL"];
    List<StepModel> stepList = [];
    documentSnapshot["steps"].forEach((stepMap) {
      stepList.add(StepModel.fromMap(stepMap: stepMap));
    });
    steps = stepList;
  }
}
