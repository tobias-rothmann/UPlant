import 'package:get/get.dart';
import 'package:uplant/models/project_model.dart';
import 'package:uplant/services/firestore_service.dart';

class ProjectsController extends GetxController {
  Rx<List<ProjectModel>> projectsList = Rx<List<ProjectModel>>([]);
  List<ProjectModel> get projects => projectsList.value;

  @override
  void onReady() {
    projectsList.bindStream(FirebaseService.projectStream());
  }
}
