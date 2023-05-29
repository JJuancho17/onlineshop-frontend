import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/order.dart';
import 'package:flutter_delivery/src/pages/administrador/orders/list/administrador_orders_list_controller.dart';
import 'package:flutter_delivery/src/utils/relative_time_util.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdministradorOrdersListPage extends StatefulWidget {

  @override
  State<AdministradorOrdersListPage> createState() => _AdministradorOrdersListPageState();
}

class _AdministradorOrdersListPageState extends State<AdministradorOrdersListPage> {
  AdministradorOrdersListController con = Get.put(AdministradorOrdersListController());
  @override
  Widget build(BuildContext context) {
    // barra de navegacion que lista las categorias
    return Obx(() => DefaultTabController(
      length: con.status.length,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.deepOrange,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: List<Widget>.generate(con.status.length, (index) {
                  return Tab(
                    child: Text(con.status[index], style: GoogleFonts.handlee(fontSize: 16)),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
              children: con.status.map((String status) {
                return FutureBuilder(
                    future: con.getOrders(status),
                    builder: (context, AsyncSnapshot<List<Order>> snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (_, index) {
                                return _cardOrder(snapshot.data![index]);
                              }
                          );
                        }
                        else{
                          return Center(child: NoDataWidget(text: 'No hay ordenes', ));
                        }

                      }
                      else{
                        return Center(child: NoDataWidget(text: 'No hay ordenes', ));
                      }
                    }
                );
              }).toList()
          )
      ),
    ));
  }

  Widget _cardOrder(Order order){
    return GestureDetector(
        onTap: () => con.goToOrderDetail(order),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          height: 150,
          child: Card(
            color: Colors.deepOrange[100],
            // le da sombra
            elevation: 3.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
            ),
            child: Stack(
              children: [
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                      ),
                  ),
                  child: Text(
                        'Orden #${order.id}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.handlee(fontSize: 20)
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text('Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)}',
                            style: GoogleFonts.handlee(fontSize: 18),)
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text('Cliente: ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}',
                            style: GoogleFonts.handlee(fontSize: 18)),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text('Entregar en: ${order.address?.address ?? ''}',
                              style: GoogleFonts.handlee(fontSize: 18))
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

