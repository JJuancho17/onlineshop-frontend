import 'dart:convert';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../enviroment/environment.dart';
import '../models/response_api.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends GetConnect{
  String url = '${Environment.API_URL}api';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  Future<List<Category>> getAll() async {

    Response response = await get(
        '$url/category/',
    );

    if(response.statusCode == 401){
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido leer esta informacion');
      return [];
    }
    List<Category> categories = Category.fromJsonList(response.body);
    return categories;
  }

  Future<ResponseApi> create(Category category) async {
    Response response = await post(
        '$url/category/',
        category.toJson(),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}