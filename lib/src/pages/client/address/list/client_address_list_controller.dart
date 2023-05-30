import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/address.dart';
import 'package:flutter_delivery/src/models/order.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provides/address_provider.dart';
import 'package:flutter_delivery/src/provides/orders_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientAddressListController extends GetxController{

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var radioValue = 0.obs;

  ClientAddressListController(){
    print('LA DIRECCION DE SESION: ${GetStorage().read('address')}');
  }

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id.toString() ?? '');
    print('address: $address');
    Address a = Address.fromJson(GetStorage().read('address') ?? {}); // direccion seleccionada por el usuario
    int index = address.indexWhere((ad) => ad.id == a.id);
    if(index != -1){// la direccion de sesion concide con un dato de la lista de direcciones
      radioValue.value = index;
    }

    return address;
  }

  void goToPaymentsMethods() {
    print('redirect to payments');
    Get.toNamed('/client/payments/payment_methods');
  }
/*
  void createOrder() async{
    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> products = [];
    if(GetStorage().read('shopping_bag') is List<Product>){
      products = GetStorage().read('shopping_bag');
    }
    else{
      products = Product.fromJsonList(GetStorage().read('shopping_bag'));
    }

    Order order = Order(
      idClient: user.id,
      idAddress: a.id,
      products: products,
      status: 'PAGADO',
      address: a
    );
    print('orden: ${order.toJson()}');
    ResponseApi responseApi = await ordersProvider.create(order);
    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
    if(responseApi.success == true){
      GetStorage().remove('shopping_bag');
      Get.toNamed('/client/payments/create');
    }

  }*/

  void handleRadioValueChange(int? value){
    radioValue.value = value!;
    print('valor seleccionado: ${value}');
    // se guarda la direccion seleccionada por el usuario en storage en sesion
    print('Addres to save: ${address[value].toJson()}');
    GetStorage().write('address', address[value].toJson());
    update();
  }
  void goToAddressCreate(){
    // lo redijira a la pantalla de crear nueva direccion
    Get.toNamed('/client/address/create');
  }
}