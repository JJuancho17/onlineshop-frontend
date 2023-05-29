import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {

  String text = '';

  NoDataWidget({this.text = ''});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/bolsa.jpg', height: 150, width: 150,),
        const SizedBox(height: 15,),
        Text(
            text,
            style: GoogleFonts.handlee(fontSize: 18)
        )
      ],
    );
  }
}
