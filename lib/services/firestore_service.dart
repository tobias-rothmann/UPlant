import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uplant/models/comment_model.dart';
import 'package:uplant/models/guide_model.dart';
import 'package:uplant/models/help_model.dart';
import 'package:uplant/models/project_model.dart';

class FirebaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static addProject(ProjectModel project) async {
    await firestore.collection("projects").add({
      'title': project.title,
      'createdOn': Timestamp.now(),
      'ownerName': project.ownerName,
      'infoText': project.infoText,
      'imageUrl': project.imageURL,
      'comments': project.comments
    });
  }

  static addHelp(HelpModel help) async {
    await firestore.collection("help").add({
      'title': help.title,
      'createdOn': Timestamp.now(),
      'ownerName': help.ownerName,
      'infoText': help.infoText,
      'imageUrl': help.imageURL,
      'comments': help.comments
    });
  }

  static Stream<List<ProjectModel>> projectStream() {
    return firestore
        .collection("projects")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProjectModel> projects = [];
      for (var project in query.docs) {
        final projectModel =
            ProjectModel.fromDocumentSnapshot(documentSnapshot: project);
        projects.add(projectModel);
      }
      return projects;
    });
  }

  static Stream<List<HelpModel>> helpStream() {
    return firestore.collection("help").snapshots().map((QuerySnapshot query) {
      List<HelpModel> helps = [];
      for (var help in query.docs) {
        final helpModel =
            HelpModel.fromDocumentSnapshot(documentSnapshot: help);
        helps.add(helpModel);
      }
      return helps;
    });
  }

  static Stream<List<GuideModel>> guidesStream() {
    return firestore
        .collection("guides")
        .snapshots()
        .map((QuerySnapshot query) {
      List<GuideModel> guides = [];
      for (var guide in query.docs) {
        final guideModel =
            GuideModel.fromDocumentSnapshot(documentSnapshot: guide);
        guides.add(guideModel);
      }
      return guides;
    });
  }

  static void addCommentProject(
      ProjectModel project, CommentModel comment) async {
    project.comments.add(comment);
    List comments = [];
    project.comments.forEach((comment) {
      comments.add(CommentModel.toMap(comment));
    });
    await firestore.collection("projects").doc(project.documentId).update({
      "comments": comments,
    });
  }

  static void addCommentHelp(HelpModel help, CommentModel comment) async {
    help.comments.add(comment);
    List comments = [];
    help.comments.forEach((comment) {
      comments.add(CommentModel.toMap(comment));
    });
    await firestore.collection("help").doc(help.documentId).update({
      "comments": comments,
    });
  }
}
