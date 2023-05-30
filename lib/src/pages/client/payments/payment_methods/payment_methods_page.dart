import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/payments/payment_methods/payment_methods_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  PaymentMethodsController con = Get.put(PaymentMethodsController());
  String selectedPaymentMethod = '';

  void continueAction() {
    // Lógica para realizar la acción deseada después de seleccionar un método de pago
    // Puedes agregar aquí el código que deseas ejecutar al presionar "Continuar"
    print('Método de pago seleccionado: $selectedPaymentMethod');
    if (selectedPaymentMethod == 'Efectivo') {
      con.createOrderWithCash();
    } else {
      con.goToPaymentsCreate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de Pago'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Efectivo'),
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'Efectivo';
              });
            },
            trailing: selectedPaymentMethod == 'Efectivo'
                ? Icon(Icons.check)
                : null,
          ),
          ListTile(
            title: Text('Tarjeta de crédito'),
            onTap: () {
              setState(() {
                selectedPaymentMethod = 'Tarjeta de crédito';
              });
            },
            trailing: selectedPaymentMethod == 'Tarjeta de crédito'
                ? Icon(Icons.check)
                : null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectedPaymentMethod.isNotEmpty ? continueAction : null,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
