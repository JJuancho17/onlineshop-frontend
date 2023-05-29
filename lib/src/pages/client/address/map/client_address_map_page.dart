import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ClientAddressMapPage extends StatelessWidget {

  ClientAddressMapController con = Get.put(ClientAddressMapController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: const Text('Ubica tu direccion en el mapa'),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          _iconMyLocation(),
          _cardAddress(),
          const Spacer(),
          _buttonAccept(context)
        ],
      ),
    ));
  }

  Widget _buttonAccept(BuildContext context){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => con.selectRefPoint(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          padding: const EdgeInsets.all(15),
        ),
          child: const Text('SELECCIONAR ESTE PUNTO'),
      ),
    );
  }
  
  Widget _cardAddress(){
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            con.addressName.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation(){
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Center(
        child: Image.asset(
            'assets/img/location.png',
          width: 50,
          height: 50,
        ),
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
        // le estamos asignando la nueva ubicacion al momento que el usuario mueva la camara y se ubique en una nueva posicion
        onCameraMove: (position) {
          con.initialPosition = position;
      },
      onCameraIdle: () async {
          await con.setLocationDraggableInfo(); // empezar a obtener la latitud y longitud de la posicion central del mapa
      },
    );
  }
}
