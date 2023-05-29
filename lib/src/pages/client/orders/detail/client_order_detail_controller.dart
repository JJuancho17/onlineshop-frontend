import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/order.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provides/orders_provider.dart';
import 'package:flutter_delivery/src/provides/users_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ClientOrderDetailController extends GetxController{

  Order order = Order.fromJson(Get.arguments['order']);

  var total = 0.0.obs;
  var idDelivery = ''.obs;

  UsersProvider usersProvider = UsersProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<User> users = <User>[].obs;

  ClientOrderDetailController(){
    print('order: ${order.toJson()}');
    getTotal();
  }

  void goToOrderMap(){
    Get.toNamed('/client/orders/map',  arguments:{
      'order': order.toJson()
    });
  }

  void getTotal(){
    total.value = 0.0;
    order.products!.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }
}