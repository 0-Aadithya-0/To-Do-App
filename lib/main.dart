import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import "package:hive_flutter/hive_flutter.dart";
void main() async {
  await Hive.initFlutter();
  runApp(const MainApp());
  var box = await Hive.openBox("MyBox")
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"To-Do",
    
      color: Colors.amber,

      home:Homepage()
      
        
    );  
  }
  }