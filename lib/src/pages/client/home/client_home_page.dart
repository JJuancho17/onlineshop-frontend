import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery/src/utils/custom_animated_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'client_home_controller.dart';


class ClientHomePage extends StatelessWidget {
  ClientHomeController con = Get.put(ClientHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottombar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          ClientProductsListPage(),
          ClientOrdersListPage(),
          ClientProfileInfoPage()
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
              icon: const Icon(Icons.add_business_rounded),
              title:  Text('Productos', style: GoogleFonts.handlee(fontSize: 16)),
              // que se ponga en este color cuando estemos encima de este boton
              activeColor: Colors.white,
              // se pone de color negro cuando no estemos encima de este boton
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.list_alt_rounded),
              title:  Text('Mis pedidos', style: GoogleFonts.handlee(fontSize: 16)),
              // que se ponga en este color cuando estemos encima de este boton
              activeColor: Colors.white,
              // se pone de color negro cuando no estemos encima de este boton
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.person_outline),
              title:  Text('Perfil', style: GoogleFonts.handlee(fontSize: 16)),
              // que se ponga en este color cuando estemos encima de este boton
              activeColor: Colors.white,
              // se pone de color negro cuando no estemos encima de este boton
              inactiveColor: Colors.black
          ),
        ],
    ));
  }
}

