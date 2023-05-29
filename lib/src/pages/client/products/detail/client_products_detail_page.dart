import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientProductsDetailPage extends StatelessWidget {
  Product? product;

  // late significa que este variable se va a inicializar mas adelante
  late ClientProductsDetailController con;
  var counter = 0.obs;
  var price = 0.0.obs;

  ClientProductsDetailPage({ @required this.product}){
      con = Get.put(ClientProductsDetailController());
  }

  @override
  Widget build(BuildContext context) {

    con.checkIfProductsWasAdded(product!, price, counter);
    return Obx(() => Scaffold(
      bottomNavigationBar: SizedBox(
          height: 100,
          child: _buttonsAddToBag()
      ),
      body: Column(
        children: [
          _imageSlideshow(context),
          _textNameProduct(),
          _textDescriptionProduct(),
          _textGrammageProduct(),
          _textAmountProduct(),
          _textFechaCaducidadProduct(),
          _textPriceProduct()
        ],
      )
    ));
  }
  Widget _textNameProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), color: Colors.black)
      ),
    );
  }
  Widget _textDescriptionProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 16), color: Colors.black)
      ),
    );
  }
  Widget _textAmountProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
      child: Text(
        'Cantidad Disponible: ${product?.amount ?? 1}',
        style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 16), color: Colors.black)
      ),
    );
  }
  Widget _textGrammageProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
      child: Text(
        product?.grammage ?? '',
        style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 16), color: Colors.black)
      ),
    );
  }
  Widget _textFechaCaducidadProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        'Fecha de vencimiento: ${DateTime.parse(product?.date_of_expire?.toString() ?? '')}',
        style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 16), color: Colors.black)
      ),
    );
  }
  Widget _buttonsAddToBag (){
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400],),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () => con.removeItem(product!, price, counter),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(40, 37),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)
                          )
                      )
                  ),
                  child: Text(
                    '-',
                    style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 22), color: Colors.black)
                  )
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(40, 37)
                  ),
                  child: Text(
                    '${counter.value}',
                    style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), color: Colors.black)
                  )
              ),
              ElevatedButton(
                  onPressed: () => con.addItem(product!, price, counter),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(45, 37),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25)
                          )
                      )
                  ),
                  child: Text(
                    '+',
                    style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 22), color: Colors.black)
                  )
              ),
              const Spacer(),
              FloatingActionButton.extended(
                onPressed: () => con.addToBag(product!, price, counter),
                label: Text(
                  'Agregar \$${price.value}',
                  style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), color: Colors.black),),
                icon: const Icon(Icons.add, color: Colors.black,),
                backgroundColor: Colors.deepOrange,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _textPriceProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Text(
        '\$ ${product?.price.toString() ?? ''}',
          style: GoogleFonts.handlee(fontSize: 16)
      ),
    );
  }
  Widget _imageSlideshow(BuildContext context){
    // no se topea con el notch del celular
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              initialPage: 0,
              indicatorColor:  const Color(0xffFF0000),
              indicatorBackgroundColor: Colors.grey,
              children: [
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image1 != null
                      ? NetworkImage(product!.image1!)
                      : const AssetImage('assets/img/no-image.png') as ImageProvider,
                ),
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image2 != null
                      ? NetworkImage(product!.image2!)
                      : const AssetImage('assets/img/no-image.png') as ImageProvider,
                ),
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image3 != null
                      ? NetworkImage(product!.image3!)
                      : const AssetImage('assets/img/no-image.png') as ImageProvider,
                ),
              ]
          ),
        ]
      ),
    );
  }
}
