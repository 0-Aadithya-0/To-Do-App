import 'package:hive_flutter/hive_flutter.dart';
class Database {
  final MyBox = Hive.box("MyBox");

  List tasks=[];


  void Firsttime_init(){
    tasks =[["Code",false],["GYM",false]];

  }

  void db_update(){
    MyBox.put("TO-DO", tasks);
  }
  void db_load(){
    tasks = MyBox.get("TO-DO");     
  }
  }

