import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../../../../models/user.dart';
import '../../../../../provides/users_provider.dart';
import '../client_profile_info_controller.dart';

class ClientProfileUpdateController extends GetxController{

  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  ClientProfileInfoController clientProfileInfoController = Get.find();

  ClientProfileUpdateController(){
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }
  void updateInfo(BuildContext context) async {
    // metodo trim elimina los espacios en blancos del correo electronico que deje el usuario

    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;

    if (isValidForm(name, lastname, phone)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando Datos...');

      User myUser = User(
          id: user.id,
          name: name,
          lastname: lastname,
          phone: phone,
          token: user.token
      );

      if (imageFile == null) {
        ResponseApi responseApi = await usersProvider.update(myUser);
        print('response api update: ${responseApi.data}');
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        progressDialog.close();
        if (responseApi.success == true){
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value = User.fromJson(responseApi.data);
        }
      }
      else{
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        print('response api update: ${responseApi.data}');
        if (responseApi.success == true ){
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value = User.fromJson(responseApi.data);
        }
        else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
      }



      /*Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true ){
          GetStorage().write('user', responseApi.data);// almacenando datos del usuario
          goToHomePage();
        }
        else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      }); */
    }
  }

  bool isValidForm(String name, String lastname, String phone ){

    if(name.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }
    if(lastname.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }
    if(phone.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu telefono');
      return false;
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(phone)) {
      Get.snackbar('Formulario no valido', 'Ingresar numero de telefono valido');
      return false;
    }
    return true;
  }

  Future selectImages(ImageSource imageSource) async{
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImages(ImageSource.gallery);
        },
        child: const Text(
          'Galeria',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImages(ImageSource.camera);
        },
        child: const Text(
          'Camara',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
}