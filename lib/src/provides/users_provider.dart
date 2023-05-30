import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:flutter_delivery/src/enviroment/environment.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {

  String url = '${Environment.API_URL}api';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});


  Future<Response> create(User user) async {
    Response response = await post(
        '$url/register/',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    return response;
  }

  Future<List<User>> findDeliveryMen() async {
    Response response = await get(
        '$url/findDeliveryMen',
        headers: {
          'Content-Type': 'application/json',
         // 'Authorization': userSession.sessionToken ?? ''
        }
    );

    if(response.statusCode == 401){
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<User> users = User.fromJsonList(response.body);

    return users;
  }
  // ACTUALIZAR DATOS SIN IMAGEN
  Future<ResponseApi> update(User user) async {
    Response response = await put(
        '$url/users/update/',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.token ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    if (response.body == null){
      Get.snackbar('error', 'no se pudo actualizar la informacion');
      return ResponseApi();
    }

    if (response.statusCode == 401){
      Get.snackbar('error', 'no esta autorizado para realizar esta peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> createWithImage(User user, File image) async {
    Uri uri = Uri.parse('${Environment.API_URL_OLD}/api/register/image/');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['name'] = user.name!;
    request.fields['email'] = user.email!;
    request.fields['username'] = user.username!;
    request.fields['lastname'] = user.lastname!;
    request.fields['phone'] = user.phone!;
    request.fields['password'] = user.password!;

    var response = await request.send();
    var responseData = await response.stream.bytesToString(); // Leer el cuerpo de la respuesta como una cadena de texto
    var jsonBody = json.decode(responseData);
    print(jsonBody);// Analizar el cuerpo de la respuesta como un objeto JSON
    return ResponseApi.fromJson(jsonBody);

  }


  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    //request.headers['Authorization'] = userSession.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post('http://192.168.100.8:8000/api/login/',
      FormData({
        'email': email,
        'password': password
      })
    );

     // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    print('response:$responseApi');
    return responseApi;

  }

}