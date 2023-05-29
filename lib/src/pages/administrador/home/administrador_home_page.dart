import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/administrador/categories/create/administrador_categories_create_page.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_delivery/src/utils/custom_animated_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../orders/list/administrador_orders_list_page.dart';
import '../products/create/administrador_products_create_page.dart';
import 'administrador_home_controller.dart';


class AdministradorHomePage extends StatelessWidget {
  AdministradorHomeController con = Get.put(AdministradorHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottombar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          AdministradorOrdersListPage(),
          AdministradorCategoriesCreatePage(),
          AdministradorProductsCreatePage(),
          ClientProfileInfoPage(),

        ],
      ))
    );
  }
  Widget _bottombar(){
    return Obx(() => CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor: Colors.deepOrange,
        showElevation: true,
        // bordes redondeados
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        selectedIndex: con.indexTab.value,
        onItemSelected: (index) => con.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon: const Icon(Icons.list_alt),
              title: Text('Pedidos', style: GoogleFonts.handlee(fontSize: 18)),
              // que se ponga en este color cuando estemos encima de este boton
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.other_houses),
              title: Text('Categoria', style: GoogleFonts.handlee(fontSize: 18)),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.store),
              title: Text('Producto', style: GoogleFonts.handlee(fontSize: 18)),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.account_circle_rounded),
              title: Text('Perfil', style: GoogleFonts.handlee(fontSize: 18)),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
        ],
    ));
  }
}

