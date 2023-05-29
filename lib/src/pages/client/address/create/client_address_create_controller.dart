import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/address.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:flutter_delivery/src/pages/client/address/map/client_address_map_page.dart';
import 'package:flutter_delivery/src/provides/address_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController{

  TextEditingController addressController = TextEditingController();
  TextEditingController barrioController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;
  
  User user = User.fromJson(GetStorage().read('user') ?? {});
  AddressProvider addressProvider = AddressProvider();
// getFind permite utilizar todos los metodos o funciones de este controlador
  ClientAddressListController clientAddressListController = Get.find();
  
  void openGoogleMap(BuildContext context) async{
    // cuando abramos el modal boton sheet va a esperar que le devolvamos un valor de tipo mapa

    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientAddressMapPage(),
        isDismissible: false,
        enableDrag: false
    );
    print('ref point map: ${refPointMap}');
    refPointController.text = refPointMap['address'];
    latRefPoint = refPointMap['lat'];
    lngRefPoint = refPointMap['lng'];

  }

  void createAddress() async {
    String addressName = addressController.text;
    String barrio = barrioController.text;

    if(isValidForm(addressName, barrio)){
      Address address = Address(
        address: addressName,
        barrio: barrio,
        lat: latRefPoint,
        lng: lngRefPoint,
        idUser: user.id
      );
      ResponseApi responseApi = await addressProvider.create(address);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      print('responseApi: ${responseApi.data}');
      if(responseApi.success == true){
        //address.id = responseApi.data;
        GetStorage().write('address', responseApi.data);
        clientAddressListController.update();
        Get.back();
      }


    }
  }



  bool isValidForm(String address, String barrio){
    if(address.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre de la direccion', colorText: Colors.white);
      return false;
    }
    if(barrio.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre del barrio', colorText: Colors.white);
      return false;
    }
    if(latRefPoint == 0) {
      Get.snackbar('Formulario no valido', ' Selecciona el punto de referencia', colorText: Colors.white);
      return false;
    }
    if(lngRefPoint == 0) {
      Get.snackbar('Formulario no valido', ' Selecciona el punto de referencia', colorText: Colors.white);
      return false;
    }
    return true;

    }
}