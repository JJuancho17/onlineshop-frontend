import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/detail/delivery_order_detail_controller.dart';
import 'package:flutter_delivery/src/utils/relative_time_util.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class DeliveryOrderDetailPage extends StatelessWidget {

  DeliveryOrderDetailController con = Get.put(DeliveryOrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              _dataDate(),
              _dataClient(),
              _dataAddress(),
              _totalToPay(context)
            ],
          )
        ),
      appBar: AppBar(
        title: Text(
          'Orden #${con.order.id}'
        ),
      ),
      body: con.order.products!.isNotEmpty
          ? ListView(
            children: con.order.products!.map((Product product) {
              return _cardProduct(product);
          }).toList(),
      )
          : Center(child: NoDataWidget(text:'No hay ninguin producto agregado')
      )
    ));
  }

  Widget _dataClient(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Cliente Y Telefono'),
        subtitle: Text('${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''} - ${con.order.client?.phone ?? ''}'),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Direccion de entrega'),
        subtitle: Text(con.order.address?.address ?? ''),
        trailing: const Icon(Icons.location_on),
      ),
    );
  }
  Widget _dataDate(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Fecha del pedido'),
        subtitle: Text(RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0)),
        trailing: const Icon(Icons.timer),
      ),
    );
  }

  Widget _totalToPay(BuildContext context){
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total: \$${con.total.value}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              con.order.status == 'DESPACHADO' ? _buttonUpdateOrder() : con.order.status == 'EN CAMINO'
              ? _buttonGoToOrderMap() : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonUpdateOrder(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15), backgroundColor: Colors.lightBlue[200]
          ),
          onPressed: () => con.updateOrder(),
          child: const Text(
            'INICIAR ENTREGA',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }
  Widget _buttonGoToOrderMap(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15), backgroundColor: Colors.lightGreen[300]
          ),
          onPressed: () => con.goToOrderMap(),
          child: const Text(
            'VOLVER AL MAPA',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _imageProduct(Product product){
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _cardProduct(Product product){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Cantidad: ${product.quantity}',
                style: const TextStyle(
                  fontSize: 13
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
