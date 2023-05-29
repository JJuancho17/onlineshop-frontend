import 'dart:convert';
import 'dart:io';
import 'package:flutter_delivery/src/enviroment/environment.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/response_api.dart';

class ProductsProvider extends GetConnect {

  String url = '${Environment.API_URL}api';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  List<Product> product = [];
  Future<List<Product>> findByCategory(int category) async {
    Response response = await get(
        '$url/categories/$category/products/',
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    );
    if(response.statusCode==200){
      product.clear();
    }
    List<Product> products = Product.fromJsonList(response.body);
    return products;
  }

  Future<List<Product>> findByNameAndCategory(int category, String name) async {
    Response response = await get(
        '$url/findByNameAndCategory/$category/$name',
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Product> products = Product.fromJsonList(response.body);

    return products;
  }

  Future<ResponseApi> create(Product product, List<File> images) async {
    Uri uri = Uri.parse('${Environment.API_URL_OLD}/api/products/create/');
    final request = http.MultipartRequest('POST', uri);
    //request.headers['Authorization'] = userSession.sessionToken ?? '';

    // Adjuntar las imágenes al formulario
    for (int i = 0; i < images.length; i++) {
      var stream = http.ByteStream(images[i].openRead());
      var length = await images[i].length();
      var multipartFile = http.MultipartFile(
        'files',
        stream,
        length,
        filename: 'image_$i.jpg',
        contentType: MediaType('image', 'jpeg'), // Ajusta el tipo de contenido según tus necesidades
      );
      request.files.add(multipartFile);
    }

    // Adjuntar los datos del producto al formulario
    request.fields['name'] = product.name!;
    request.fields['description'] = product.description!;
    request.fields['price'] = product.price.toString();
    request.fields['date_of_expire'] = product.date_of_expire.toString();
    request.fields['amount'] = product.amount.toString();
    request.fields['grammage'] = product.grammage!;
    request.fields['id_category'] = product.category.toString();

    var response = await request.send();
    var responseData = await response.stream.bytesToString(); // Leer el cuerpo de la respuesta como una cadena de texto
    var jsonBody = json.decode(responseData); // Analizar el cuerpo de la respuesta como un objeto JSON
    return ResponseApi.fromJson(jsonBody);
  }
}