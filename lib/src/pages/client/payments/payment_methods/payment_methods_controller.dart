import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../models/address.dart';
import '../../../../models/order.dart';
import '../../../../models/product.dart';
import '../../../../models/response_api.dart';
import '../../../../models/user.dart';
import '../../../../provides/address_provider.dart';
import '../../../../provides/orders_provider.dart';

class PaymentMethodsController extends GetxController{

  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  void createOrderWithCash() async {
    Address a = Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> products = [];
    if (GetStorage().read('shopping_bag') is List<Product>) {
      products = GetStorage().read('shopping_bag');
    }
    else {
      products = Product.fromJsonList(GetStorage().read('shopping_bag'));
    }

    Order order = Order(
        idClient: user.id,
        idAddress: a.id,
        products: products,
        status: 'POR COBRAR',
        address: a
    );
    print('orden: ${order.toJson()}');
    ResponseApi responseApi = await ordersProvider.create(order);
    Fluttertoast.showToast(
        msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
    if (responseApi.success == true) {
      GetStorage().remove('shopping_bag');
      Get.toNamed('/client/home');
    }
  }
  void goToPaymentsCreate() {
    Get.toNamed('/client/payment/create');
  }
}