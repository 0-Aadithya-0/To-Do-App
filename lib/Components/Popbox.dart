import 'package:flutter/material.dart';
import 'package:to_do/Components/button.dart';

class Popbox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback Onsave;
  final VoidCallback Oncancel;

  Popbox({super.key,required this.controller,required this.Oncancel,required this.Onsave});
  
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent,
      alignment: Alignment(0,-0.3),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: controller,
                cursorColor: Colors.black,
                 enableInteractiveSelection: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                  )
              ),
            ),
            Row(
              children: [
                Mybutton(name:"Cancel", onPressed:Oncancel ),
                Spacer(),
                Mybutton(name: "Save", onPressed:Onsave )
              ],
            )
          ],
        ),
      ),
      
      
    );
  }
}
