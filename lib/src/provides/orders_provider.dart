import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/order.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../enviroment/environment.dart';
import '../models/response_api.dart';
import '../models/user.dart';

class OrdersProvider extends GetConnect{
  String url = '${Environment.API_URL}api';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  // METODO PARA LISTAR LAS ORDENES POR EL ESTADO
  Future<List<Order>> findByStatus(String status) async {
    Response response = await get(
        '$url/findByStatus/$status',
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    );

    if(response.statusCode == 401){
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido leer esta informacion', colorText: Colors.white);
      return [];
    }
    
    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }
  // METODO PARA LISTAR LAS ORDENES POR EL ID DEL REPARTIDOR Y SU ESTADO
  Future<List<Order>> findByDeliveryAndStatus(String idDelivery, String status) async {
    Response response = await get(
        '$url/findByDeliveryAndStatus/$idDelivery/$status',
        headers: {
          'Content-Type': 'application/json',
         // 'Authorization': userSession.sessionToken ?? ''
        }
    );

    if(response.statusCode == 401){
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido leer esta informacion', colorText: Colors.white);
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  // METODO PARA LISTAR LAS ORDENES POR EL ID DEL CLIENTE Y SU ESTADO
  Future<List<Order>> findByClientAndStatus(String idClient, String status) async {
    Response response = await get(
        '$url/findByClientAndStatus/$idClient/$status',
        headers: {
          'Content-Type': 'application/json',
         // 'Authorization': userSession.sessionToken ?? ''
        }
    );

    if(response.statusCode == 401){
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido leer esta informacion', colorText: Colors.white);
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }
  // METODO PARA CREAR UNA ORDEN
  Future<ResponseApi> create(Order order) async {
    Response response = await post(
        '$url/order/create/',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    print('respuesta de orden: $response.body');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
  // METODO QUE ACTUALIZA LA ORDEN AL ESTADO DESPACHADO
  Future<ResponseApi> updateToDispatched(Order order) async {
    Response response = await put(
        '$url/updateToDispatched',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    print(responseApi);
    return responseApi;
  }
  // METODO PARA ACTUALIZAR LA ORDEN AL ESTADO EN CAMINO
  Future<ResponseApi> updateToOnTheWay(Order order) async {
    Response response = await put(
        '$url/updateToOnTheWay',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
  Future<ResponseApi> updateToDelivered(Order order) async {
    Response response = await put(
        '$url/updateToDelivered',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
  Future<ResponseApi> updateLatLng(Order order) async {
    Response response = await put(
        '$url/updateLatLng',
        order.toJson(),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}