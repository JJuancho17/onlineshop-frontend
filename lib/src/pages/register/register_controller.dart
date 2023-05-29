import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provides/users_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    // metodo trim elimina los espacios en blancos del correo electronico que deje el usuario
    String email = emailController.text.trim();
    String name = nameController.text.toUpperCase();
    String username = usernameController.text.toUpperCase();
    String lastname = lastnameController.text.toUpperCase();
    String phone = phoneController.text;
    // en el caso del password el usuario no podra poner espacios en blanco
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();


    print('email ${email}');
    print('password ${password}');
    print('name: ${name}');
    print('username: ${username}');
    print('lastname: ${lastname}');
    print('telefono: ${phone}');
    print('password: ${password}');


    if (isValidForm(email, name, username, lastname, phone, password, confirmPassword)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando Datos...');

      User user = User(
        email: email,
        name: name,
        username: username,
        lastname: lastname,
        phone: phone,
        password: password,
      );
      print('usuario: ${user.toJson()}');
      progressDialog.close();
      Response response = await usersProvider.create(user);
      print('response: ${response.body}');
      /*     Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));


        progressDialog.close();
        ResponseApi responseApi = ResponseApi();
        if (responseApi.success == true ){
          GetStorage().write('user', responseApi.data);// almacenando datos del usuario
          goToHomePage();
        }
        else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }

       */
      }
    }
  }
  void goToHomePage(){
    Get.offNamedUntil('/client/products/list', (route) => false);
  }
  bool isValidForm(String email,String name, String username, String lastname, String phone, String password, String confirmPassword){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }
    if (!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'el email no es valido');
      return false;
    }
    if(name.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }
    if(username.isEmpty){
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
    if (password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes imgresar el password');
    }
    if (confirmPassword.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes imgresar de nuevo tu password');
    }
    if(password != confirmPassword){
      Get.snackbar('Formulario no valido', 'Las contraseñas no conciden');
      return false;
    }
    /*
    if (imageFile == null){
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
    }

     */
    return true;
  }
  /*
  Future selectImages(ImageSource imageSource) async{
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){
      imageFile = File(image.path);
      update();
    }
  }

   */

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          //selectImages(ImageSource.gallery);
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
          //selectImages(ImageSource.camera);
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
