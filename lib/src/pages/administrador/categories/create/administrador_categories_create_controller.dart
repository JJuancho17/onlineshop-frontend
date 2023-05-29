import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provides/categories_provider.dart';
import 'package:get/get.dart';

import '../../../../models/category.dart';

class AdministradorCategoriesCreateController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  // metodo para crear una nueva categoria
  void createCategory() async {

    String name = nameController.text;
    String description = descriptionController.text;
    print('Name: ${name}');
    print('description: ${description}');

    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(
        name: name,
        description: description
      );
      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      if (responseApi.success == true){
        clearForm();
        update();
      }
    }
    else{
      Get.snackbar('Formulario no valido', 'Ingresa todos los campos para crear la categoria');
    }
  }
  // metodo para limpiar el formulario luego de crear una categoria
  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
    update();
  }
}

