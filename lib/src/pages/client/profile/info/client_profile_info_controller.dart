import 'package:flutter_delivery/src/models/Rol.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProfileInfoController extends GetxController{
  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;
  User user1 = User.fromJson(GetStorage().read('user') ?? {});

  void signOut(){
    GetStorage().remove('address');
    GetStorage().remove('shopping_bag');
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
  void goToProfileUpdate(){
    Get.toNamed('/client/profile/update');
  }

  void goToRoles(){
    Get.offNamedUntil('/roles', (route) => false);
  }

}
