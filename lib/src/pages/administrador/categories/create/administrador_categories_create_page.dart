import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/administrador/categories/create/administrador_categories_create_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class AdministradorCategoriesCreatePage extends StatelessWidget {
  AdministradorCategoriesCreateController con = Get.put(AdministradorCategoriesCreateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AdministradorCategoriesCreateController> (
          builder: (value) => Stack(//posicionar elementos uno encima de otro
          children: [
            _boxForm(context),
            _textNewCategory(context),
          ],
        )
    ));
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
            _textFieldDescription(),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }
  Widget _textFieldName(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre',
            hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
            prefixIcon: const Icon(
                Icons.note_alt_rounded,
              color: Colors.black,
            )
        ),
      ),
    );
  }
  Widget _textFieldDescription(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'Descripcion',
            hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
            prefixIcon: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: const Icon(
                  Icons.description,
                color: Colors.black,
              ),
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
          onPressed: () {
            con.createCategory();
          },
        label: Text('CREAR CATEGORIA', style: GoogleFonts.handlee(fontSize: 13),),
        icon: const Icon(Icons.new_label_outlined, color: Colors.black,),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  Widget _textNewCategory(BuildContext context){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const CircleAvatar(backgroundImage: AssetImage('assets/img/category.jpg'),radius: 50,),
            const Divider(color: Colors.transparent,),
            Text(
              'NUEVA CATEGORIA',
                style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
            ),
          ],
        )
      ),
    );
  }
  Widget _textYourInfo(){
    return Container(
        margin: const EdgeInsets.only( bottom: 50),
        child: Text(
            'INGRESA LOS SIGUIENTES DATOS',
            style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
        )
    );
  }
}
