import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/home/client_home_page.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/pages/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Future.delayed(const Duration(milliseconds: 2000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: FractionallySizedBox(
                  widthFactor: .6,
                    child: Image(image: AssetImage('assets/img/logo3.jpeg'))),
              ),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 5),
              Text('Bienvenido a Online Shop')
            ],
          ),
        ));
  }
}

