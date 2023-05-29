import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:flutter_delivery/src/provides/categories_provider.dart';
import 'package:flutter_delivery/src/provides/products_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart' hide ModalBottonSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController extends GetxController{
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  List<Category> categories = <Category>[].obs;
  var productName = ''.obs;
  Timer? searchOnStoppedTyping;

  ClientProductsListController(){
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName.value = text;
      print('TEXTO COMPLETO: ${text}');
    });
  }

  Future<List<Product>> getProducts(int category) async {
    return await productsProvider.findByCategory(category);
  }

  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  }

  void openBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet(
        expand: true,
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product,)
    );
  }

}
