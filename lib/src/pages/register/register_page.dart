import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/register/register_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController con = Get.put(RegisterController());

  bool _passwordVisible1 = true;
  bool _passwordVisible =  true;

  @override

  void initState() {
    _passwordVisible = false;
    _passwordVisible1 = false;
  }

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
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 30, right: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFieldName(),
            _textFieldUserName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _buttonRegister(context)
          ],
        ),
      ),
    );
  }
  Widget _textFieldEmail(){
    return TextField(
      controller: con.emailController ,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Correo Electronico',
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
            Icons.email_outlined,
            color: Colors.black,
          )
      ),
    );
  }
  Widget _textFieldName(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: TextField(
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
      ),
    );
  }
  Widget _textFieldUserName(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: TextField(
        controller: con.userNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre de usuario',
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
  Widget _textFieldLastName(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
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
      margin: const EdgeInsets.only(top: 5),
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
  Widget _textFieldPassword(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
            hintText: 'Contraseña',
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
              Icons.password,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible =! _passwordVisible;
                  });
                },
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                )
            )
        ),
      ),
    );
  }
  Widget _textFieldConfirmPassword(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: TextField(
        controller: con.confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: !_passwordVisible1,
        decoration: InputDecoration(
            hintText: 'Confirmar Contraseña',
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
              Icons.password_outlined,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible1 =! _passwordVisible1;
                  });
                },
                icon: Icon(
                  _passwordVisible1
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                )
            )
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 2, right: 2, top: 40),
      child: FloatingActionButton.extended(
          onPressed: () => con.register(context),
          label: const Text('REGISTRARSE', style: TextStyle(color: Colors.black),),
          icon: const Icon(Icons.app_registration, color: Colors.black,),
          backgroundColor: Colors.deepOrange,
      ),
    );
  }
  Widget _imageUser(BuildContext context){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<RegisterController>(
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ?  FileImage(con.imageFile!)
                    : const AssetImage('assets/img/user_profile_2.png') as ImageProvider,
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
        margin: const EdgeInsets.only(top: 10, bottom: 45),
        child: Text(
            'INGRESA LOS SIGUIENTES DATOS',
            style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
        )
    );
  }
}

