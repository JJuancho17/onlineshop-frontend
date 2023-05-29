import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Rol.dart';
import '../../../roles/roles_controller.dart';

class ClientProfileInfoPage extends StatelessWidget {

  ClientProfileInfoController con = Get.put(ClientProfileInfoController());
  RolesController con1 = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=> Stack( //posicionar elementos uno encima de otro
          children: [
            _boxForm(context),
            Column(
              children: [
                _buttonRoles(context),
                _buttonSignOut(),
              ],

            ),
          ],
        )),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.7,
      margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height * 0.1, left: 40, right: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.85)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _imageUser(context),
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }
  Widget _buttonSignOut(){
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: ( ) => con.signOut(),
            icon:const Icon(
              Icons.power_settings_new,
              color: Colors.deepOrange ,
              size: 30,
            ),
          ),
        )
    );
  }
  Widget _cardRol(Rol rol) {
    return SafeArea(
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                alignment: Alignment.topRight,
                onPressed: () => con1.goToPageRol(rol),
                icon: const Icon(
                  Icons.person_pin_circle_outlined,
                  color: Colors.deepOrange,
                ),
              ),
              Text(
                rol.name ?? '',
                  style:  GoogleFonts.handlee(fontSize: 10, color: Colors.deepOrange),
                textAlign: TextAlign.center,

              ),
            ],
          ),
        )
    );
  }

  Widget _buttonRoles(BuildContext context){
    return Expanded(
      child: ListView(
        children: con1.user.roles != null
            ? con1.user.roles!.map<Widget>((Rol rol) {
          return _cardRol(rol);
        }).toList()
            : <Widget>[],
      ),
    );
  }



  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: FloatingActionButton.extended(
        onPressed: () => con.goToProfileUpdate(),
        label: Text('ACTUALIZAR DATOS', style: GoogleFonts.handlee(fontSize: 15),),
        icon: const Icon(Icons.update, color: Colors.black,),
        backgroundColor: Colors.deepOrange,
      ),
      );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: con.user.value.image != null
              ?  NetworkImage(con.user.value.image!)
              : const AssetImage('assets/img/user_profile_2.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textName() {
    return Container(
      margin: const EdgeInsets.only(top:50),
      child: ListTile(
          leading: const Icon(Icons.account_circle_rounded),
          title: Text('${con.user.value.name ?? ''} ${con.user.value.lastname ?? ''}', style:  GoogleFonts.handlee(fontSize: 18),),
          subtitle:  Text('Nombre de usuario', style:  GoogleFonts.handlee(fontSize: 18),),
      ),
    );
  }
  Widget _textEmail() {
    return ListTile(
        leading: const Icon(Icons.email_rounded),
        title: Text(con.user.value.email ?? '', style:  GoogleFonts.handlee(fontSize: 18),),
        subtitle: Text('Correo electronico', style:  GoogleFonts.handlee(fontSize: 18),),
    );
  }
  Widget _textPhone() {
    return ListTile(
        leading: const Icon(Icons.phone_android),
        title: Text(con.user.value.phone ?? '', style:  GoogleFonts.handlee(fontSize: 18),),
        subtitle:  Text('Telefono', style: GoogleFonts.handlee(fontSize: 18),),
    );
  }
}

