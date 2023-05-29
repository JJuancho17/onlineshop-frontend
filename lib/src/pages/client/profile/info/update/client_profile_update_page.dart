import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/update/client_profile_update_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
class ClientProfileUpdatePage extends StatelessWidget {

  ClientProfileUpdateController con = Get.put(ClientProfileUpdateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(//posicionar elementos uno encima de otro
          children: [
            _boxForm(context),
            _imageUser(context),
            _buttonBack()
          ],
        )
    );

  }

  Widget _buttonBack(){
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: ( ) => Get.back(),
            icon:const Icon(
              Icons.arrow_back_ios,
              color: Colors.deepOrange ,
              size: 30,
            ) ,
          ),
        )
    );
  }
  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 30, right: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return TextField(
      controller: con.nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Nombre',
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
                color: Colors.deepOrange
            ),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(16),
          //fillColor: Colors.deepOrange,
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.black,
          )
      ),
    );
  }
  Widget _textFieldLastName(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellido',
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            // fillColor: Colors.deepOrange,
            prefixIcon: const Icon(
              Icons.person_2,
              color: Colors.black,
            )
        ),
      ),
    );
  }
  Widget _textFieldPhone(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Telefono',
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            //fillColor: Colors.deepOrange,
            prefixIcon: const Icon(
              Icons.phone_enabled,
              color: Colors.black,
            )
        ),
      ),
    );
  }
  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: FloatingActionButton.extended(
          onPressed: () => con.updateInfo(context),
        label: const Text('ACTUALIZAR', style: TextStyle(color: Colors.black),),
        icon: const Icon(Icons.update, color: Colors.black,),
        backgroundColor: Colors.deepOrange,
          )
      );
  }
  Widget _imageUser(BuildContext context){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<ClientProfileUpdateController>(
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ?  FileImage(con.imageFile!)
                    : con.user.image != null
                    ? NetworkImage(con.user.image!) :
                const AssetImage('assets/img/user_profile_2.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            )
        ),
      ),
    );
  }
  Widget _textYourInfo(){
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 30),
        child: Text(
            'INGRESA LOS SIGUIENTES DATOS',
            style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
        )
    );
  }
}
