import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/enviroment/environment.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key? key}) : super(key: key);

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    // barra de navegacion que lista las categorias
    return Obx(() => DefaultTabController(
      length: con.categories.length,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: AppBar(
              flexibleSpace: Container(
                color: Colors.deepOrange,
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.topCenter,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    _textFieldSearch(context),
                    _iconShoppingBat()
                  ],
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: List<Widget>.generate(con.categories.length, (index) {
                  return Tab(
                    child: Text(con.categories[index].name ?? '', style: GoogleFonts.handlee(fontSize: 16)),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
              children: con.categories.map((Category category) {
                return FutureBuilder(
                    future: con.getProducts(category.id ?? 1),
                    builder: (context, AsyncSnapshot<List<Product>> snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (_, index) {
                                return _cardProduct(context, snapshot.data![index]);
                              }
                          );
                        }
                        else{
                          return NoDataWidget(text: 'No hay productos disponibles');
                        }

                      }
                      else{
                        return NoDataWidget(text: 'No hay productos disponibles', );
                      }
                    }
                );
              }).toList()
          )
      ),
    ));
  }
  Widget _iconShoppingBat(){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: IconButton(
            onPressed: () => con.goToOrderCreate(),
            icon: const Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.white,
            )
        ),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width  * 0.75,
        child: TextField(
          onChanged: con.onChangeText,
          decoration: InputDecoration(
              hintText: 'Buscar producto',
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              hintStyle: GoogleFonts.handlee(fontSize: 16),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              contentPadding: EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? '', style: GoogleFonts.handlee(fontSize: 18)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                      style: GoogleFonts.handlee(fontSize: 16)
                  ),
                  const SizedBox(height:15),
                  Text(
                    '\$${product.price.toString()}',
                      style: GoogleFonts.handlee(fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              trailing: SizedBox(
                height: 70,
                width: 60,
                // le da un estilo redondeado a la imagen
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
              ),
            ),
          ),
          Divider(height: 1, indent: 37, color: Colors.grey[300], endIndent: 37,)
        ],
      ),
    );
  }
}


