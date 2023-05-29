import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/user.dart';

class ClientHomeController extends GetxController{
  // obs = observador para realizar cambio de estados

  var indexTab = 0.obs;
  void changeTab(int index){
    indexTab.value = index;
  }

  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}