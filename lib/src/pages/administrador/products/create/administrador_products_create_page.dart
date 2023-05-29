import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/pages/administrador/products/create/administrador_products_create_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdministradorProductsCreatePage extends StatelessWidget {
  AdministradorProductsCreateController con = Get.put(AdministradorProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() =>  Stack(//posicionar elementos uno encima de otro
              children: [
                _boxForm(context),
                _textNewProduct(context),
              ],
        ))
    );
  }

  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18, left: 50, right: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _textFieldPrice(),
            _textFieldDate(context),
            _textFieldAmount(),
            _textFieldGrammage(),
            _dropDownCategories(con.categories),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<AdministradorProductsCreateController>(
                    builder: (value) => _cardImage(context, con.imageFile1, 1),
                ),
                const SizedBox(width: 5),
                GetBuilder<AdministradorProductsCreateController>(
                  builder: (value) =>  _cardImage(context, con.imageFile2, 2),
                ),
                const SizedBox(width: 5),
                GetBuilder<AdministradorProductsCreateController>(
                  builder: (value) =>  _cardImage(context, con.imageFile3, 3),
                ),
              ],
            ),

            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down,
            color: Color(0xffFF0000),
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar categoria',
          style: GoogleFonts.handlee(fontSize: 18),
        ),
        items: _dropDownItems(categories),
        value: con.idCategory.value == '' ? null : con.idCategory.value ,
        onChanged: (option) {
          print('opcion seleccionada: ${option}');
          con.idCategory.value = option.toString();
        },
      ),
    );
  }
  // DropDownMenuItem es para desplegar las categorias que tenemos
  List<DropdownMenuItem<String?>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
          value: category.id.toString(),
          child: Text(
            category.name ?? ''
          ),
      ));
    });
    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile){
    return GestureDetector(
          onTap: () => con.showAlertDialog(context, numberFile),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 70,
                width: MediaQuery.of(context).size.width * 0.20,
                child: imageFile != null ?
                Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                )
                  :
              const Image(image: AssetImage('assets/img/agregar_img.png') )
          ),
    ));
  }

  Widget _textFieldName(){
    return TextField(
      controller: con.nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Nombre',
          hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
          prefixIcon: const Icon(
              Icons.note_alt,
            color: Colors.black,
          )
      ),
    );
  }

  Widget _textFieldDate(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: con.dateOfExpireController,
        decoration:  InputDecoration(
          prefixIcon: const Icon(
            Icons.calendar_month_sharp,
            color: Colors.black,
          ),
          hintText: "Fecha de caducidad",
          hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2024));
          if(pickedDate != null){
            con.dateOfExpireController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          }
        },
      ),
    );
  }

  Widget _textFieldAmount(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
            controller: con.amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Cantidad',
                hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
              prefixIcon: const Icon(
                Icons.colorize_outlined,
                color: Colors.black,
              )
            ),
          )
    );
  }
  Widget _textFieldGrammage(){
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: TextField(
          controller: con.grammageController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: 'Gramaje',
              hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
              prefixIcon: const Icon(
                  Icons.calculate_outlined,
                color: Colors.black,
              )
          ),
        )
    );
  }
  Widget _textFieldPrice(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Precio',
            hintStyle: GoogleFonts.handlee(fontSize: 18, color: Colors.grey),
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
            prefixIcon: const Icon(
                Icons.monetization_on,
              color: Colors.black,
            )
        ),
      ),
    );
  }
  Widget _textFieldDescription(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
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
                  width: 0,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: const Icon(
                  Icons.note,
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
            con.createProduct(context);
          },
        label: Text('CREAR PRODUCTO', style:
        GoogleFonts.handlee(fontSize: 16),),
        icon: const Icon(Icons.app_registration_rounded, color: Colors.black,),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  Widget _textNewProduct(BuildContext context){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: Text(
          'NUEVO PRODUCTO',
          style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
        ),
      ),
    );
  }
  Widget _textInfo(){
    return Container(
      margin: const EdgeInsets.only( bottom: 30),
      child: Text(
        'INGRESA LOS SIGUIENTES DATOS',
          style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
      ),
    );
  }
}
