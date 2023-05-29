import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provides/categories_provider.dart';
import 'package:flutter_delivery/src/provides/products_provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../../../models/category.dart';

class AdministradorProductsCreateController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateOfExpireController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController grammageController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  var idCategory = ''.obs;
  List<Category> categories = <Category>[].obs;
  ProductsProvider productsProvider = ProductsProvider();

  AdministradorProductsCreateController(){
    getCategories();
  }

  void getCategories() async {
    update();
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  void createProduct(BuildContext context) async {

    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;
    String date_of_expire = dateOfExpireController.text;
    String amount = amountController.text;
    String grammage = grammageController.text;

    print('Name: $name');
    print('description: $description');
    print('Price: $price');
    print('date: $date_of_expire');
    print('cantidad: $amount');
    print('grammar: $grammage');
    print('idCategory: $idCategory');
    ProgressDialog progressDialog = ProgressDialog(context: context);

    if (isValidForm(name, description, price, date_of_expire, amount, grammage)) {

      Product product = Product(
          name: name,
          description: description,
          price: double.parse(price),
          date_of_expire: DateTime.parse(date_of_expire),
          amount: int.parse(amount),
          grammage: grammage,
          category: int.parse(idCategory.toString())
      );
      progressDialog.show(max: 100, msg:'Espera un momento...');
      List<File> images = [];
      images.add(imageFile1!);
      images.add(imageFile2!);
      images.add(imageFile3!);
      ResponseApi responseApi = await productsProvider.create(product, images);
      progressDialog.close();
      print(responseApi.toJson());
      Get.snackbar('Proceso terminado', responseApi.message ?? '');
      if(responseApi.success == true){
        clearForm();
      }
    }
  }

  bool isValidForm(String name, String description, String price, String date_of_expire, String amount, String grammage ){
      if(name.isEmpty) {
        Get.snackbar('Formulario no valido', 'Ingresa el nombre del producto', colorText: Colors.white);
        return false;
      }
      if(description.isEmpty) {
        Get.snackbar('Formulario no valido', 'Ingresa la descripcion del producto', colorText: Colors.white);
        return false;
      }
      if(price.isEmpty) {
        Get.snackbar('Formulario no valido', 'Ingresa el precio del producto', colorText: Colors.white);
        return false;
      }
      if(date_of_expire.isEmpty) {
        Get.snackbar('Formulario no valido', 'Ingresa la fecha de caducidad del producto', colorText: Colors.white);
        return false;
      }
      if(amount.isEmpty) {
        Get.snackbar('Formulario no valido', 'Ingresa la cantidad del producto', colorText: Colors.white);
        return false;
      }
      if(grammage.isEmpty) {
        Get.snackbar('Formulario no valido', 'Ingresa el gramaje del producto', colorText: Colors.white);
        return false;
      }
      if(idCategory.value == '') {
        Get.snackbar('Formulario no valido', 'Debes seleccionar la categoria del producto', colorText: Colors.white);
        return false;
      }
      if(imageFile1 ==  null){
        Get.snackbar('Formulario no valido', 'Debes seleccionar la imagen numero 1 del producto', colorText: Colors.white);
        return false;
      }
      if(imageFile2 ==  null){
        Get.snackbar('Formulario no valido', 'Debes seleccionar la imagen numero 2 del producto', colorText: Colors.white);
        return false;
      }
      if(imageFile3 ==  null){
        Get.snackbar('Formulario no valido', 'Debes seleccionar la imagen numero 3 del producto', colorText: Colors.white);
        return false;
      }
      return true;
  }

  Future selectImages(ImageSource imageSource, int numberFile) async{
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){

      if(numberFile == 1){
        imageFile1 = File(image.path);
      }
      else if(numberFile == 2){
        imageFile2 = File(image.path);
      }
      else if(numberFile == 3){
        imageFile3 = File(image.path);
      }
      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImages(ImageSource.gallery, numberFile);
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
          selectImages(ImageSource.camera, numberFile);
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

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    dateOfExpireController.text = '';
    amountController.text = '';
    grammageController.text = '';
    imageFile1 =  null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory.value = '';
    update();
  }


}

