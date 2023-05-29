

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/pages/client/home/client_home_page.dart';
import 'package:flutter_delivery/src/provides/users_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    // metodo trim elimina los espacios en blancos del correo electronico que deje el usuario
    String email = emailController.text.trim();
    // en el caso del password el usuario no podra poner espacios en blanco
    String password = passwordController.text.trim();


    print('email ${email}');
    print('password ${password}');

    if (isValidForm(email, password)){

      ResponseApi responseApi = await usersProvider.login(email, password);

      print('response api: ${responseApi.toJson()}');

      if(responseApi.success == true){
        GetStorage().write('user', responseApi.data);// almacenando datos del usuario
        goToClientHomePage();
        /* User myUser = User.fromJson(GetStorage().read('user') ?? {});
        print('roles length: ${user.roles!.length}');
        if(myUser.roles!.length > 1){
          goToRolesPage();
        }
        else{// solo un rol
          goToClientHomePage();
        }
        //goToHomePage();
        //goToRolesPage();*/
      }
      else {
        Get.snackbar('Login fallido', 'Credenciales incorrectas');
      }
    }
  }

    void goToClientHomePage() {
      Get.offNamedUntil('/client/home', (route) => false);
    }
    void goToRolesPage() {
      Get.offNamedUntil('/roles', (route) => false);
    }
    bool isValidForm(String email, String password) {
      if (email.isEmpty) {
        Get.snackbar('Formulario no valido', 'Debes ingresar el email');
        return false;
      }
      if (!GetUtils.isEmail(email)) {
        Get.snackbar('Formulario no valido', 'el email no es valido');
        return false;
      }
      if (password.isEmpty) {
        Get.snackbar('Formulario no valido', 'Debes imgresar el password');
      }
      return true;
    }
}