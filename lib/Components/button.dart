import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {

  final String name ;
  final VoidCallback onPressed;
  Mybutton({super.key, required this.name,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top: 30),
      child: MaterialButton(
        color: Color.fromARGB(255, 32, 32, 32),
        textColor: const Color.fromARGB(255, 222, 222, 222),
        onPressed: onPressed,
        child: Text(name)),
    ) ;
      
  }
}