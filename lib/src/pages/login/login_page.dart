
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/home/client_home_page.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/pages/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../models/response_api.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  LoginController con = Get.put(LoginController());

  bool _passwordVisible =  true;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: 90,
          child: _textDontHaveAccount(),
        ),
        body: Stack(//posicionar elementos uno encima de otro
          children: [
            _boxForm(context),
            Column(//posicionar elementos uno de bajo de otro de manera vertical
              children: [
                _imageCover(),
              ],
            )
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
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }
  Widget _textFieldEmail(){
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Nombre de usuario',
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
                Icons.email_outlined,
                color: Colors.black,
            )
        ),
      ),
    );
  }
  Widget _textFieldPassword(){
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 40, right: 40),
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
                  width: 4,
                  style: BorderStyle.none,
                  color: Colors.deepOrange
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            //fillColor: Colors.deepOrange,
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
  Widget _buttonLogin(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: FloatingActionButton.extended(
         onPressed: () => con.login(),
          label: const Text('INGRESAR', style: TextStyle(color: Colors.black),),
          icon: const Icon(Icons.login_rounded, color: Colors.black,),
          backgroundColor: Colors.deepOrange,
      ),
    );
  }
  Widget _textYourInfo(){
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 45),
      child: Text(
        'INGRESA LOS SIGUIENTES DATOS',
          style: GoogleFonts.handlee(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), color: Colors.black)
      )
    );
  }
  Widget _textDontHaveAccount(){
    return Row(//nos permite ubicar elementos uno al lado del otro de manera horiozntal
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '¿No tienes cuenta?',
          style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 17,
          ),
        ),
        const SizedBox(width: 7),
        GestureDetector(
          onTap: () => con.goToRegisterPage(),
          child: const Text(
            'Registrate aqui',
            style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),
          ),
        )
      ],
    );
  }
  // la raya al piso significa q este metodo sera privado
  // solo se puede acceder dede esta misma clase
  Widget _imageCover(){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/logo4.jpeg',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}



