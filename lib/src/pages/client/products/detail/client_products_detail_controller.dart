import 'package:flutter_delivery/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProductsDetailController extends GetxController{

  List<Product> selectedProducts = [];

  void checkIfProductsWasAdded(Product product, var price, var counter, /*var amount*/){

    price.value = product.price ?? 0.0;
    // amount.value = product.amount ?? '';
    if(GetStorage().read('shopping_bag') != null){

      if(GetStorage().read('shopping_bag') is List<Product>){
        selectedProducts = GetStorage().read('shopping_bag');

      }
      else{
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }

      int index = selectedProducts.indexWhere((p) => p.id == product?.id);

      if(index != -1){// el producto ya fue agregado
        counter.value = selectedProducts[index].quantity ?? 0;
        price.value = product.price! * counter.value;
        selectedProducts.forEach((p) {
          //print('Producto: ${p.toJson()}');
        });
      }
    }
  }

  void addToBag(Product product, var price, var counter){
    if(counter.value > 0 ){
      // validar si el producto ya fue agregado con getStorage a la sesion del dispositivo
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      if(index == -1){// no ha sido agregado
        product.quantity ??= counter.value;
        print('producto:${product.toJson()}');
        selectedProducts.add(product);
      }
      else{// el producto ya ha sido agregado en storage
        selectedProducts[index].quantity = counter.value;
      }
      // guardamos los productos
      GetStorage().write('shopping_bag', selectedProducts);
      print(selectedProducts);
      // nos permite mostrar un mensaje
      Fluttertoast.showToast(msg: 'Producto agregado');
    }
    else{
      Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item para agregar');
    }
  }



  void addItem(Product product, var price, var counter){
    counter.value = counter.value +1;
    price.value = product.price! * counter.value;
   //print('PRODUCTO AGREGADO: ${product.toJson()}');
  }
  void removeItem(Product product, var price, var counter){
    if(counter.value >0){
      counter.value = counter.value -1;
      price.value = product.price! * counter.value;
      //print('PRODUCTO AGREGADO: ${product.toJson()}');
    }
  }
}