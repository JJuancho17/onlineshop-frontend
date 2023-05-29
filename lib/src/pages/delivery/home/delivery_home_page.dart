import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery/src/utils/custom_animated_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'delivery_home_controller.dart';


class DeliveryHomePage extends StatelessWidget {
  DeliveryHomeController con = Get.put(DeliveryHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottombar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          DeliveryOrdersListPage(),
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
              icon: const Icon(Icons.list),
              title:  Text('Pedidos', style: GoogleFonts.handlee(fontSize: 16)),
              // que se ponga en este color cuando estemos encima de este boton
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title:  Text('Perfil', style: GoogleFonts.handlee(fontSize: 16)),
              activeColor: Colors.white,
              inactiveColor: Colors.black
          ),
        ],
    ));
  }
}

