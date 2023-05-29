import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/orders/map/client_orders_map_controller.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ClientOrdersMapPage extends StatelessWidget {

  ClientOrdersMapController con = Get.put(ClientOrdersMapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientOrdersMapController>(builder: (value) =>  Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.67,
              child: _googleMaps()
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonBack(),
                    _iconCenterMyLocation(),
                  ],
                ),
                const Spacer(),
                _cardOrderInfo(context),
              ],
            ),
          ),
           const Spacer(),
          // _buttonAccept(context)
        ],
      ),
    ));
  }

  Widget _buttonBack(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: ( ) => Get.back(),
        icon:const Icon(
          Icons.arrow_back_ios,
          color: Colors.black ,
          size: 30,
        ) ,
      ),
    );
  }

  Widget _iconCenterMyLocation(){
    return GestureDetector(
      onTap: () => con.centerPosition(),
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardOrderInfo(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0,3)
          )
        ]
      ),
      child: Column(
        children: [
          _listTileAddress(
              con.order.address?.barrio ?? '',
              'Barrio',
              Icons.my_location
          ),
          _listTileAddress(
              con.order.address?.address ?? '',
              'Direccion',
              Icons.location_on
          ),
          const Divider(color: Colors.grey, endIndent: 30, indent: 30,),
          _deliveryInfo()
        ],
      ),
    );
  }

  Widget _deliveryInfo(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          _imageDelivery(),
          const SizedBox(width: 15,),
          Text(
            '${con.order.delivery?.name ?? ''} ${con.order.delivery?.lastname ?? ''}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            // no vaya a ocupar mas de una linea
            maxLines: 1,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[200]

            ),
            child: IconButton(
                onPressed: () => con.callNumber(),
                icon: const Icon(Icons.phone, color: Colors.black,)
            ),
          )
        ],
      ),
    );
  }
  Widget _imageDelivery(){
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: con.order.delivery!.image != null
              ? NetworkImage(con.order.delivery!.image!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
          placeholder: const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _listTileAddress(String title, String subtitle, IconData iconData ){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          subtitle
        ),
        trailing: Icon(iconData),
      ),
    );
  }

  Widget _googleMaps(){
    return GoogleMap(
      // posisicion inicial
        initialCameraPosition: con.initialPosition,
        // tipo de mapa
        mapType: MapType.normal,
        onMapCreated: con.onMapCreate,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        markers: Set<Marker>.of(con.markers.values),
        polylines: con.polylines,
    );
  }
}
