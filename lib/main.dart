import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/home/splashScreen.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/administrador/home/administrador_home_page.dart';
import 'package:flutter_delivery/src/pages/administrador/orders/detail/administrador_order_detail_page.dart';
import 'package:flutter_delivery/src/pages/administrador/orders/list/administrador_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/client/address/create/client_address_create_page.dart';
import 'package:flutter_delivery/src/pages/client/address/list/client_address_list_page.dart';
import 'package:flutter_delivery/src/pages/client/home/client_home_page.dart';
import 'package:flutter_delivery/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:flutter_delivery/src/pages/client/orders/detail/client_order_detail_page.dart';
import 'package:flutter_delivery/src/pages/client/orders/map/client_orders_map_page.dart';
import 'package:flutter_delivery/src/pages/client/payments/create/client_payments_create_page.dart';
import 'package:flutter_delivery/src/pages/client/payments/installments/client_payments_installments_page.dart';
import 'package:flutter_delivery/src/pages/client/payments/payment_methods/payment_methods_page.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/update/client_profile_update_page.dart';
import 'package:flutter_delivery/src/pages/delivery/home/delivery_home_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/detail/delivery_order_detail_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/map/delivery_orders_map_page.dart';
import 'package:flutter_delivery/src/pages/home/home_page.dart';
import 'package:flutter_delivery/src/pages/login/login_page.dart';
import 'package:flutter_delivery/src/pages/register/register_page.dart';
import 'package:flutter_delivery/src/pages/roles/roles_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
User userSession = User.fromJson(GetStorage().read('user') ?? {});
void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // nombre de la aplicacion
      title: 'Online-Shop',
      // sirve para quitar el baner que sale por defecto en flutter
      debugShowCheckedModeBanner: false,
      // ruta inicial
      // el / es ruta raiz

      //initialRoute: '/',
      initialRoute: userSession.id != null ? userSession.roles!.length > 1 ? '/client/home' : '/client/home' : '/',
      // propiedad getPages es un arreglo y se ponen las pantallas que vamos a mostrar
      getPages: [
        // en nombre debe ir la ruta q establecimos incialmente
        // rutas
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/administrador/orders/list', page: () => AdministradorOrdersListPage()),
        GetPage(name: '/administrador/orders/detail', page: () => AdministradorOrderDetailPage()),
        GetPage(name: '/delivery/orders/list', page: () => DeliveryOrdersListPage()),
        GetPage(name: '/delivery/orders/detail', page: () => DeliveryOrderDetailPage()),
        GetPage(name: '/delivery/orders/map', page: () => DeliveryOrdersMapPage()),
        GetPage(name: '/delivery/home', page: () => DeliveryHomePage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
        GetPage(name: '/client/home', page: () => ClientHomePage()),
        GetPage(name: '/administrador/home', page: () => AdministradorHomePage()),
        GetPage(name: '/client/profile/info', page: () => ClientProfileInfoPage()),
        GetPage(name: '/client/profile/update', page: () => ClientProfileUpdatePage()),
        GetPage(name: '/client/orders/create', page: () => ClientOrdersCreatePage()),
        GetPage(name: '/client/orders/map', page: () => ClientOrdersMapPage()),
        GetPage(name: '/client/orders/detail', page: () => ClientOrderDetailPage()),
        GetPage(name: '/client/payments/payment_methods', page: () => PaymentMethodsPage()),
        GetPage(name: '/client/address/list', page: () => ClientAddressListPage()),
        GetPage(name: '/client/address/list', page: () => ClientAddressListPage()),
        GetPage(name: '/client/payments/create', page: () => ClientPaymentsCreatePage()),
        GetPage(name: '/client/payments/installments', page: () => ClientPaymentsInstallmentsPage()),

      ],
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        colorScheme: const ColorScheme(
            secondary: Colors.deepOrange,
            brightness: Brightness.light,
            primary: Colors.deepOrange,
            onBackground: Colors.black,
            onPrimary: Colors.black,
            surface: Colors.black,
            onSurface: Colors.black,
            error: Colors.grey,
            onError: Colors.grey,
            onSecondary: Colors.black,
            background: Colors.black,


        )
      ),
      navigatorKey: Get.key,
    );
  }
}
