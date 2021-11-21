import 'package:get/get.dart';
import 'package:uplant/models/help_model.dart';
import 'package:uplant/services/firestore_service.dart';

class HelpController extends GetxController {
  Rx<List<HelpModel>> helpList = Rx<List<HelpModel>>([]);
  List<HelpModel> get helps => helpList.value;

  @override
  void onReady() {
    helpList.bindStream(FirebaseService.helpStream());
  }
}
