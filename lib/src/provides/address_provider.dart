import 'package:flutter_delivery/src/models/address.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../enviroment/environment.dart';
import '../models/response_api.dart';
import '../models/user.dart';

class AddressProvider extends GetConnect{

  String url = '${Environment.API_URL}api';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  // metodo para desplegar las direcciones creadas por el id_user
  Future<List<Address>> findByUser(String idUser) async {
    Response response = await get(
        '$url/address/$idUser/',
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': userSession.sessionToken ?? ''
        }
    );

    if(response.statusCode == 401){
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Address> address = Address.fromJsonList(response.body);
    print(address);
    return address;

  }


  Future<ResponseApi> create(Address address) async {
    Response response = await post(
        '$url/address/create/',
        address.toJson(),
        headers: {
          'Content-Type': 'application/json',
         // 'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}