import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/administrador/orders/detail/administrador_order_detail_controller.dart';
import 'package:flutter_delivery/src/utils/relative_time_util.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class AdministradorOrderDetailPage extends StatelessWidget {

  AdministradorOrderDetailController con = Get.put(AdministradorOrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: con.order.status == 'PAGADO' ? MediaQuery.of(context).size.height * 0.51
            : MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              _dataDate(),
              _dataClient(),
              _dataAddress(),
              _dataDelivery(),
              _totalToPay(context)
            ],
          )
        ),
      appBar: AppBar(
        title: Text(
          'Orden #${con.order.id}', style: GoogleFonts.handlee(fontSize: 18)
        ),
      ),
      body: con.order.products!.isNotEmpty
          ? ListView(
            children: con.order.products!.map((Product product) {
              return _cardProduct(product);
          }).toList(),
      )
          : Center(child: NoDataWidget(text:'No hay ninguin producto agregado', )
      )
    ));
  }

  Widget _dataClient(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Cliente Y Telefono: ', style: GoogleFonts.handlee(fontSize: 18)),
        subtitle: Text('${con.order.client?.name ?? ''} ${con.order.client?.lastname ?? ''} - ${con.order.client?.phone ?? ''}', style: GoogleFonts.handlee(fontSize: 18)),
        trailing: const Icon(Icons.account_circle),
      ),
    );
  }

  Widget _dataDelivery(){
    return con.order.status != 'PAGADO' ? Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Repartidor asignado: ', style: GoogleFonts.handlee(fontSize: 18)),
        subtitle: Text('${con.order.delivery?.name ?? ''} ${con.order.delivery?.lastname ?? ''} - ${con.order.delivery?.phone ?? ''}', style: GoogleFonts.handlee(fontSize: 18)),
        trailing: const Icon(Icons.time_to_leave_rounded),
      ),
    )
    : Container();
  }

  Widget _dataAddress(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Direccion de entrega', style: GoogleFonts.handlee(fontSize: 18)),
        subtitle: Text(con.order.address?.address ?? '', style: GoogleFonts.handlee(fontSize: 18)),
        trailing: const Icon(Icons.location_searching),
      ),
    );
  }
  Widget _dataDate(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Fecha del pedido', style: GoogleFonts.handlee(fontSize: 18)),
        subtitle: Text(RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0), style: GoogleFonts.handlee(fontSize: 18)),
        trailing: const Icon(Icons.timelapse_rounded),
      ),
    );
  }

  Widget _totalToPay(BuildContext context){
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        con.order.status == 'PAGADO' ? Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
              'Asignar repartidor', style: GoogleFonts.handlee(fontSize: 18),

          ),
        )
        : Container(),
        con.order.status == 'PAGADO' ? _dropDownDeliveryMen(con.users) : Container(),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: con.order.status == 'PAGADO' ? MainAxisAlignment.center
            : MainAxisAlignment.start,
            children: [
              Text(
                'Total: \$${con.total.value}',
                  style: GoogleFonts.handlee(fontSize: 18)
              ),
              con.order.status == 'PAGADO' ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)
                    ),
                    onPressed: () => con.updateOrder(),
                    child: Text(
                      'DESPACHAR ORDEN',
                        style: GoogleFonts.handlee(fontSize: 18)
                    )
                ),
              ) : Container()
            ],
          ),
        )
      ],
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
                  style: GoogleFonts.handlee(fontSize: 18)
              ),
              const SizedBox(height: 6),
              Text(
                'Cantidad: ${product.quantity}',
                  style: GoogleFonts.handlee(fontSize: 18)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dropDownDeliveryMen(List<User> users) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      margin: const EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down,
            color: Colors.deepOrange,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar repartidor',
            style: GoogleFonts.handlee(fontSize: 18)
        ),
        items: _dropDownItems(users),
        value: con.idDelivery.value == '' ? null : con.idDelivery.value ,
        onChanged: (option) {
          print('opcion seleccionada: $option');
          con.idDelivery.value = option.toString();
        },
      ),
    );
  }
  // DropDownMenuItem es para desplegar las categorias que tenemos
  List<DropdownMenuItem<String?>> _dropDownItems(List<User> users){
    List<DropdownMenuItem<String>> list = [];
    users.forEach((user) {
      list.add(DropdownMenuItem(
        value: user.id.toString(),
        child: Row(
          children: [
            SizedBox(
              height: 40,
                width: 40,
              child: FadeInImage(
                image: user.image != null
                  ? NetworkImage(user.image!)
                  : const AssetImage('assets/img/no-image.png') as ImageProvider,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 50),
                placeholder: const AssetImage('assets/img/no-image.png'),
              ),
            ),
            const SizedBox(width: 15,),
            Text(
                user.name ?? '', style: GoogleFonts.handlee(fontSize: 18)
            ),
          ],
        ),
      ));
    });
    return list;
  }
}
