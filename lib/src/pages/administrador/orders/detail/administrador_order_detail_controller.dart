import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/order.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provides/orders_provider.dart';
import 'package:flutter_delivery/src/provides/users_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AdministradorOrderDetailController extends GetxController{

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  AdministradorOrderDetailController(){
    print('order: ${order.toJson()}');
    getDeliveryMen();
    getTotal();
  }


  void updateOrder() async {
    if (idDelivery.value != ''){// el usuario selecciono el repartidor
      order.idDelivery = idDelivery.value.toString() as int?;
      ResponseApi responseApi = await ordersProvider.updateToDispatched(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if(responseApi.success == true){
        Get.offNamedUntil('/administrador/home', (route) => false);
      }
    }
    else{
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor', colorText: Colors.white);
    }
  }
  void getDeliveryMen() async{
    var result = await usersProvider.findDeliveryMen();
    users.clear();
    users.addAll(result);
  }
  void getTotal(){
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }
}