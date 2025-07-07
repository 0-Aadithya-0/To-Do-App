import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {

  final String name ;
  final VoidCallback onPressed;
  Mybutton({super.key, required this.name,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top: 30),
      child:ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 32, 32, 32),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 30)
          ),
        onPressed: onPressed,
        child: Text(name,style: TextStyle(color:const Color.fromARGB(255, 222, 222, 222)),)),
    ) ;
      
  }
}