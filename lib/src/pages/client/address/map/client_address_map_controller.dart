import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
class ClientAddressMapController extends GetxController{

  // esta variable sirve para cargar el mapa en una posicion cercana a nuestra ciudad
  CameraPosition initialPosition =  const CameraPosition(
      target: LatLng(
          4.7963761, -74.3495549
      ),
    zoom: 14
  );


  LatLng? addressLatLng;
  var addressName = ''.obs;

  Completer<GoogleMapController> mapController = Completer();

  Position? position;

  ClientAddressMapController(){
    checkGPS();// verifica si el gps esta activo y requerir los permisos
  }

  Future setLocationDraggableInfo() async{

    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;


    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    if(address.isNotEmpty){
      String direction = address[0].thoroughfare ?? '';
      String street = address[0].subThoroughfare ?? '';
      String city = address[0].locality ?? '';
      String department = address[0].administrativeArea ?? '';
      // String country = address[0].country ?? '';

      addressName.value = '$direction #$street, $city, $department ';
      addressLatLng = LatLng(lat, lng);
      
      print('lat y lng: ${addressLatLng?.latitude ?? 0} ${addressLatLng?.longitude ?? 0}');


    }
  }

  void selectRefPoint(BuildContext context){
    if(addressLatLng != null){
      Map<String, dynamic> data = {
        'address' : addressName.value,
        'lat': addressLatLng!.latitude,
        'lng': addressLatLng!.longitude
      };
      // este metodo nos permite devolver hacia atras
      Navigator.pop(context, data);
    }
  }

  void checkGPS() async{
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if(isLocationEnabled == true){
      updateLocation();
    }
    else{
      bool locationGPS = await location.Location().requestService();
      if(locationGPS == true){
        updateLocation();
      }
    }
  }

  void updateLocation() async {
    try{
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition(); // obtenemos la lat y long de la posicion actual
      animatedCamaraPosition(position?.latitude ?? 4.7963761, position?.longitude ??-74.3495549 );
    }catch(e) {
      print('error: $e');
    }
  }
  Future animatedCamaraPosition(double lat, double lng) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                lat, lng
            ),
          zoom: 13,
          bearing: 0
        )
    ));
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void onMapCreate(GoogleMapController controller){
    //controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#64779e"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"color":"#334e87"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#023e58"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#283d6a"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#6f9ba5"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#023e58"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#3C7680"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"road","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2c6675"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#b0d5ce"}]},{"featureType":"road.highway","elementType":"labels.text.stroke","stylers":[{"color":"#023e58"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"transit","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"transit.line","elementType":"geometry.fill","stylers":[{"color":"#283d6a"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#3a4762"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#4e6d70"}]}]');
    mapController.complete(controller);
  }
}