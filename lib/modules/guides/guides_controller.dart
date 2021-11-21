import 'package:get/get.dart';
import 'package:uplant/models/guide_model.dart';
import 'package:uplant/services/firestore_service.dart';

class GuidesController extends GetxController {
  Rx<List<GuideModel>> guidesList = Rx<List<GuideModel>>([]);
  List<GuideModel> get guides => guidesList.value;

  @override
  void onReady() {
    guidesList.bindStream(FirebaseService.guidesStream());
  }
}
