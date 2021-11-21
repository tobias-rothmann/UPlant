import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  late Timestamp createdOn;
  late String ownerName;
  late String comment;

  CommentModel({
    required this.createdOn,
    required this.ownerName,
    required this.comment,
  });

  CommentModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    ownerName = documentSnapshot["ownerName"];
    createdOn = documentSnapshot["createdOn"];
    comment = documentSnapshot["comment"];
  }

  CommentModel.fromMap({required Map commentMap}) {
    createdOn = commentMap["createdOn"];
    ownerName = commentMap["ownerName"];
    comment = commentMap["comment"];
  }

  static Map toMap(CommentModel commentModel) {
    return {
      "createdOn": commentModel.createdOn,
      "ownerName": commentModel.ownerName,
      "comment": commentModel.comment,
    };
  }
}
