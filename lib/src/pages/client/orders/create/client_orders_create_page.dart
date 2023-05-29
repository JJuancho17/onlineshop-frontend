import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientOrdersCreatePage extends StatelessWidget {

  ClientOrdersCreateController con  = Get.put(ClientOrdersCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(245, 245, 245, 1),
        height: 100,
        child: _totalToPay(context),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title:  Text(
            'Mi orden',
            style: GoogleFonts.handlee(fontSize: 23, color: Colors.white)
        ),
      ),
      body: con.selectedProducts.isNotEmpty
        ? ListView(
          children: con.selectedProducts.map((Product product) {
            return _cardProduct(product);
          }).toList(),
      )
          : Center(child: NoDataWidget(text:'No hay ninguin producto agregado',)
      )
    ));
  }

  Widget _totalToPay(BuildContext context){
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300]),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Total: \$${con.total.value}',
                  style: GoogleFonts.handlee(fontSize: 16)
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: FloatingActionButton.extended(
                  onPressed: () => con.goToAddressList(),
                  label: const Text('Confirmar Orden', style: TextStyle(color: Colors.black, fontSize: 13),),
                  icon: const Icon(Icons.check, color: Colors.black,),
                  backgroundColor: Colors.deepOrange,
                ),
              )
            ],
          ),
        )
      ],
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
                  style: GoogleFonts.handlee(fontSize: 16)
              ),
              const SizedBox(height: 7,),
              _buttonsAddOrRemove(product)
            ],
          ),
          // ocupa el resto de la pantalla y envia los ultimos elenentos a la parte derecha de la pantalla
          const Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }
  
  Widget _iconDelete(Product product){
    return IconButton(
        onPressed: () => con.deleteItem(product),
        icon: const Icon(
          Icons.delete_rounded,
          color: Colors.deepOrange,
        )
    );
  }

  Widget _textPrice(Product product){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        '\$${product.price! * product.quantity!}',
          style: GoogleFonts.handlee(fontSize: 16, fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product){
    return Row(
      children: [
        GestureDetector(
          onTap: () => con.removeItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8)
              )
            ),

            child:  Text('-', style: GoogleFonts.handlee(fontSize: 16)),

          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () => con.addItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)
                )
            ),
            child:  Text('+', style: GoogleFonts.handlee(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _imageProduct(Product product){
    return SizedBox(
      height: 70,
      width: 70,
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
}
