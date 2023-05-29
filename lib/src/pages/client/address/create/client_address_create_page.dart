import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientAddressCreatePage extends StatelessWidget {

  ClientAddressCreateController con = Get.put(ClientAddressCreateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(//posicionar elementos uno encima de otro
          children: [
            _boxForm(context),
            _textNewAddress(context),
            _iconBack()
          ],
        )
    );
  }
  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldAddress(),
            _textFieldBarrio(),
            _textFieldRefPoint(context),
            const SizedBox(height: 20,),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _iconBack(){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, size: 30,)
        ),
      ),
    );
  }
  Widget _textFieldAddress(){
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: TextField(
        controller: con.addressController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Dirección',
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 4,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            //fillColor: Colors.deepOrange,
            prefixIcon: const Icon(
              Icons.note_alt_sharp,
              color: Colors.black,
            )
        ),
      ),
    );
  }

  Widget _textFieldBarrio(){
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
      child: TextField(
        controller: con.barrioController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Barrio',
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 4,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            //fillColor: Colors.deepOrange,
            prefixIcon: const Icon(
              Icons.house,
              color: Colors.black,
            )
        ),
      ),
    );
  }
  Widget _textFieldRefPoint(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
      child: TextField(
        onTap: () => con.openGoogleMap(context),
        controller: con.refPointController,
        keyboardType: TextInputType.text,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            hintText: 'Punto de referencia',
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 4,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            //fillColor: Colors.deepOrange,
            prefixIcon: const Icon(
              Icons.map_outlined,
              color: Colors.black,
            )
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical:10),
      child: FloatingActionButton.extended(
        onPressed: () => con.createAddress(),
        label: const Text('Crear Direccion', style: TextStyle(color: Colors.black),),
        icon: const Icon(Icons.create, color: Colors.black,),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  Widget _textNewAddress(BuildContext context){
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(top: 45),
          alignment: Alignment.topCenter,
          child:  Column(
            children: [
              const CircleAvatar(backgroundImage: AssetImage('assets/img/refPoint.jpg'),radius: 60,),
              const Divider(color: Colors.transparent,),
              Text(
                'NUEVA DIRECCION',
                style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
              ),
            ],
          )
      ),
    );
  }
  Widget _textYourInfo(){
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 35),
        child: Text(
            'INGRESA LOS SIGUIENTES DATOS',
            style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
        )
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
